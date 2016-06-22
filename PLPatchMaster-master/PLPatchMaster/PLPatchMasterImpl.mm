/*
 * Author: Landon Fuller <landonf@plausiblelabs.com>
 *
 * Copyright (c) 2013-2015 Plausible Labs Cooperative, Inc.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

#import "PLPatchMasterImpl.hpp"
#import "PLPatchMaster.h"

extern "C" {
#define PL_BLOCKIMP_PRIVATE 1 // Required for the PLBlockIMP trampoline API
#import <PLBlockIMP/trampoline_table.h>
}

#import "PLBlockLayout.h"
#import "PMLog.h"

#import <mach-o/dyld.h>

#import <objc/runtime.h>

/* Include the generated PLBlockIMP headers */
extern "C" {
#ifdef __i386__
#include "blockimp_x86_32.h"
#include "blockimp_x86_32_stret.h"
#elif defined(__x86_64__)
#include "blockimp_x86_64.h"
#include "blockimp_x86_64_stret.h"
#elif defined(__arm64__)
#include "blockimp_arm64.h"
#elif defined(__arm__)
#include "blockimp_arm.h"
#include "blockimp_arm_stret.h"
#else
#error Unsupported Architecture
#endif
}

/* The ARM64 ABI does not require (or support) the _stret objc_msgSend variant */
#ifdef __arm64__
#define STRET_TABLE_REQUIRED 0
#define STRET_TABLE_CONFIG pl_blockimp_patch_table_page_config
#define STRET_TABLE blockimp_table
#else
#define STRET_TABLE_REQUIRED 1
#define STRET_TABLE_CONFIG pl_blockimp_patch_table_stret_page_config
#define STRET_TABLE blockimp_table_stret
#endif

/** Notification sent (synchronously) when an image is added. */
static NSString *PLPatchMasterImageDidLoadNotification = @"PLPatchMasterImageDidLoadNotification";

/** Notification user-info key containing the mach header pointer for a newly added image */
static NSString *PLPatchMasterMachHeaderKey = @"PLPatchMasterMachHeaderKey";

static void perform_dyld_rebinding (const PatchTable &patches, const char *image_name, const struct mach_header *mh);

/* Global lock for our mutable trampoline state. Must be held when accessing the trampoline tables. */
static pthread_mutex_t blockimp_lock = PTHREAD_MUTEX_INITIALIZER;

/* Trampoline tables for objc_msgSend() dispatch. */
static pl_trampoline_table *blockimp_table = NULL;

#if STRET_TABLE_REQUIRED
/* Trampoline tables for objc_msgSend_stret() dispatch. */
static pl_trampoline_table *blockimp_table_stret = NULL;
#endif /* STRET_TABLE_REQUIRED */

/**
 * Create a new PLPatchIMP block IMP trampoline.
 */
static IMP patch_imp_implementationWithBlock (id block, SEL selector, IMP origIMP) {
    /* Allocate the appropriate trampoline type. */
    pl_trampoline *tramp;
    struct Block_layout *bl = (__bridge struct Block_layout *) block;
    if (bl->flags & BLOCK_USE_STRET) {
        tramp = pl_trampoline_alloc(&STRET_TABLE_CONFIG, &blockimp_lock, &STRET_TABLE);
    } else {
        tramp = pl_trampoline_alloc(&pl_blockimp_patch_table_page_config, &blockimp_lock, &blockimp_table);
    }
    
    /* Configure the trampoline */
    void **config = (void **) pl_trampoline_data_ptr((void *) tramp->trampoline);
    config[0] = Block_copy((__bridge void *)block);
    config[1] = tramp;
    config[2] = (void *) origIMP;
    config[3] = selector;
    
    /* Return the function pointer. */
    return (IMP) tramp->trampoline;
}

#if UNUSED

/**
 * Return the backing block for an IMP trampoline.
 */
static void *patch_imp_getBlock (IMP anImp) {
    /* Fetch the config data and return the block reference. */
    void **config = pl_trampoline_data_ptr(anImp);
    return config[0];
}

#endif

/**
 * Deallocate the IMP trampoline.
 */
static BOOL patch_imp_removeBlock (IMP anImp) {
    /* Fetch the config data */
    void **config = (void **) pl_trampoline_data_ptr((void *) anImp);
    auto bl = (struct Block_layout *) config[0];
    auto tramp = (pl_trampoline *) config[1];
    
    /* Drop the trampoline allocation */
    if (bl->flags & BLOCK_USE_STRET) {
        pl_trampoline_free(&blockimp_lock, &STRET_TABLE, tramp);
    } else {
        pl_trampoline_free(&blockimp_lock, &blockimp_table, tramp);
    }
    
    /* Release the block */
    Block_release(config[0]);
    
    // TODO - what does this return value mean?
    return YES;
}


/**
 * @internal
 * Concrete internal implementation of PLPatchMaster. This is implemented seperately to allow us to hide
 * the PLPatchMaster instance variables when targeting Objective-C runtimes (i.e. Mac i386).
 */
@implementation PLPatchMasterImpl

/* Handle dyld image load notifications. These *should* be dispatched after the Objective-C callbacks have been
 * dispatched, but there's no gaurantee. It's possible, though unlikely, that this could break in a future release of Mac OS X. */
static void dyld_image_add_cb (const struct mach_header *mh, intptr_t vmaddr_slide) {
    auto *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject: [NSValue valueWithPointer: mh] forKey: PLPatchMasterMachHeaderKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: PLPatchMasterImageDidLoadNotification object: nil userInfo: userInfo];
}

+ (void) initialize {
    if (([self class] != [PLPatchMasterImpl class]))
        return;
    
    /* Register the shared dyld image add function */
    _dyld_register_func_for_add_image(dyld_image_add_cb);
}

- (instancetype) init {
    if ((self = [super init]) == nil)
        return nil;
    
    /* Default state */
    _classPatches = [[NSMutableDictionary dictionary] retain];
    _instancePatches = [[NSMutableDictionary dictionary] retain];
    _restoreBlocks = [[NSMutableArray array] retain];
    _pendingPatches = [[NSMutableArray array] retain];
    _lock = OS_SPINLOCK_INIT;
    
    /* Watch for image loads */
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleImageLoad:) name: PLPatchMasterImageDidLoadNotification object: nil];
    
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [_classPatches release];
    [_instancePatches release];
    [_restoreBlocks release];
    [_pendingPatches release];
    
    [super dealloc];
}

// PLPatchMasterImageDidLoadNotification notification handler
- (void) handleImageLoad: (NSNotification *) notification {
    /* Apply all dyld symbol rebindings */
    {
        auto mh = (const struct mach_header *) [[[notification userInfo] objectForKey: PLPatchMasterMachHeaderKey] pointerValue];
        const char *name = nullptr;
        for (uint32_t i = 0; i < _dyld_image_count(); i++) {
            if (_dyld_get_image_header(i) != mh)
                continue;
            name = _dyld_get_image_name(i);
        }
        
        /* Apply any symbol rebindings immediately */
        if (name == nullptr) {
            PMLog("Failed to lookup Mach-O image name; skipping patching");
        } else {
            OSSpinLockLock(&_lock);
            perform_dyld_rebinding(_symbolPatches, name, mh);
            OSSpinLockUnlock(&_lock);
        }
    }
    
    /* Apply all Objective-C patches */
    NSArray *blocks;
    OSSpinLockLock(&_lock); {
        blocks = [[_pendingPatches copy] autorelease];
    } OSSpinLockUnlock(&_lock);
    
    for (BOOL (^patcher)(void) in blocks) {
        if (patcher()) {
            OSSpinLockLock(&_lock); {
                [_pendingPatches removeObject: patcher];
            } OSSpinLockUnlock(&_lock);
        }
    }
}

/**
 * Patch the class method @a selector of @a className, where @a className may not yet have been loaded,
 * or @a selector may not yet have been registered by a category.
 *
 * This may be used to register patches that will be automatically applied when the bundle or framework
 * to which they apply is loaded.
 *
 * @param className The name of the class to patch. The class may not yet have been loaded.
 * @param selector The selector to patch.
 * @param replacementBlock The new implementation for @a selector. The first parameter must be a pointer to PLPatchIMP; the
 * remainder of the parameters must match the original method.
 */
- (void) patchFutureClassWithName: (NSString *) className selector: (SEL) selector replacementBlock: (id) replacementBlock {
    /* Create a patch block */
    BOOL (^patcher)(void) = ^{
        Class cls = NSClassFromString(className);
        if (!cls)
            return NO;
        
        if (![cls respondsToSelector: selector])
            return NO;
        
        /* Class and selector are registered! Patch away! */
        return [self patchClass: cls selector: selector replacementBlock: replacementBlock];
    };
    
    /* Register the patch */
    OSSpinLockLock(&_lock); {
        [_pendingPatches addObject: patcher];
    } OSSpinLockUnlock(&_lock);
    
    /* Try immediately -- the patch may already have been viable, or the required image may have been concurrently loaded */
    if (patcher()) {
        OSSpinLockLock(&_lock); {
            [_pendingPatches removeObject: patcher];
        } OSSpinLockUnlock(&_lock);
    }
}

/**
 * Patch the instance method @a selector of @a className, where @a className may not yet have been loaded,
 * or @a selector may not yet have been registered by a category.
 *
 * This may be used to register patches that will be automatically applied when the bundle or framework
 * to which they apply is loaded.
 *
 * @param className The name of the class to patch. The class may not yet have been loaded.
 * @param selector The selector to patch.
 * @param replacementBlock The new implementation for @a selector. The first parameter must be a pointer to PLPatchIMP; the
 * remainder of the parameters must match the original method.
 */
- (void) patchInstancesWithFutureClassName: (NSString *) className selector: (SEL) selector replacementBlock: (id) replacementBlock {
    /* Create a patch block */
    BOOL (^patcher)(void) = ^{
        Class cls = NSClassFromString(className);
        if (!cls)
            return NO;
        
        if (![cls instancesRespondToSelector: selector])
            return NO;
        
        /* Class and selector are registered! Patch away! */
        return [self patchInstancesWithClass: cls selector: selector replacementBlock: replacementBlock];
    };
    
    /* Register the patch */
    OSSpinLockLock(&_lock); {
        [_pendingPatches addObject: patcher];
    } OSSpinLockUnlock(&_lock);
    
    /* Try immediately -- the patch may already have been viable, or the required image may have been concurrently loaded */
    if (patcher()) {
        OSSpinLockLock(&_lock); {
            [_pendingPatches removeObject: patcher];
        } OSSpinLockUnlock(&_lock);
    }
}

/**
 * Patch the class method @a selector of @a cls.
 *
 * @param cls The class to patch.
 * @param selector The selector to patch.
 * @param replacementBlock The new implementation for @a selector. The first parameter must be a pointer to PLPatchIMP; the
 * remainder of the parameters must match the original method.
 *
 * @return Returns YES on success, or NO if @a selector is not a defined @a cls method.
 */
- (BOOL) patchClass: (Class) cls selector: (SEL) selector replacementBlock: (id) replacementBlock {
    Method m = class_getClassMethod(cls, selector);
    if (m == NULL)
        return NO;
    
    /* Insert the new implementation */
    IMP oldIMP = method_getImplementation(m);
    IMP newIMP = patch_imp_implementationWithBlock(replacementBlock, selector, oldIMP);
    
    if (!class_addMethod(object_getClass(cls), selector, newIMP, method_getTypeEncoding(m))) {
        /* Method already exists in subclass, we just need to swap the IMP */
        method_setImplementation(m, newIMP);
    }
    
    OSSpinLockLock(&_lock); {
        /* If the method has already been patched once, we won't need to restore the IMP */
        BOOL restoreIMP = YES;
        if (_classPatches[cls][NSStringFromSelector(selector)] != nil)
            restoreIMP = NO;
        
        /* Otherwise, record the patch and save a restore block */
        if (_classPatches[cls] == nil)
            _classPatches[(id)cls] = [NSMutableSet setWithObject: NSStringFromSelector(selector)];
        else
            [_classPatches[(id)cls] addObject: NSStringFromSelector(selector)];
        
        [_restoreBlocks addObject: [[^{
            if (restoreIMP) {
                Method m = class_getClassMethod(cls, selector);
                method_setImplementation(m, oldIMP);
            }
            patch_imp_removeBlock(newIMP);
        } copy] autorelease]];
    } OSSpinLockUnlock(&_lock);
    
    return YES;
}

/**
 * Patch the instance method @a selector of @a cls.
 *
 * @param cls The class to patch.
 * @param selector The selector to patch.
 * @param replacementBlock The new implementation for @a selector. The first parameter must be a pointer to PLPatchIMP; the
 * remainder of the parameters must match the original method.
 *
 * @return Returns YES on success, or NO if @a selector is not a defined @a cls instance method.
 */
- (BOOL) patchInstancesWithClass: (Class) cls selector: (SEL) selector replacementBlock: (id) replacementBlock {
    @autoreleasepool {
        Method m = class_getInstanceMethod(cls, selector);
        if (m == NULL)
            return NO;
        
        /* Insert the new implementation */
        IMP oldIMP = method_getImplementation(m);
        IMP newIMP = patch_imp_implementationWithBlock(replacementBlock, selector, oldIMP);
        
        if (!class_addMethod(cls, selector, newIMP, method_getTypeEncoding(m))) {
            /* Method already exists in subclass, we just need to swap the IMP */
            method_setImplementation(m, newIMP);
        }
        
        OSSpinLockLock(&_lock); {
            /* If the method has already been patched once, we won't need to restore the IMP */
            BOOL restoreIMP = YES;
            NSMutableSet *knownSels = _instancePatches[cls];
            if ([knownSels containsObject: NSStringFromSelector(selector)])
                restoreIMP = NO;
            
            /* Otherwise, record the patch and save a restore block */
            if (_instancePatches[cls] == nil)
                _instancePatches[(id)cls] = [NSMutableSet setWithObject: NSStringFromSelector(selector)];
            else
                [_instancePatches[(id)cls] addObject: NSStringFromSelector(selector)];
            
            [_restoreBlocks addObject: [[^{
                if (restoreIMP) {
                    Method m = class_getInstanceMethod(cls, selector);
                    method_setImplementation(m, oldIMP);
                }
                patch_imp_removeBlock(newIMP);
            } copy] autorelease]];
        } OSSpinLockUnlock(&_lock);
    }
    
    return YES;
}

/**
 * @internal
 *
 * Perform dyld-compatible symbol rebinding of the given image.
 *
 * @param patches The table of patches; if locking is required, locks must be held by the caller.
 * @param image_name The name of the image being rebound.
 * @param mh The in-memory base address of the target image.
 */
static void perform_dyld_rebinding (const PatchTable &patches, const char *image_name, const struct mach_header *mh) {
    /* Analyze the image */
    auto image = LocalImage::Analyze(image_name, (const pl_mach_header_t *) mh);
    
    /* Rebind all symbols */
    image.rebind_symbols([&patches](const bind_opstream::symbol_proc &sp) {
        // TODO: We need to evaluate when/how addend is used.
        if (sp.addend() != 0) {
            // PMDebug("Skipping unsupported symbol binding for %s:%s with non-zero addend %" PRId64, name.image().c_str(), name.symbol().c_str(), addend);
            return;
        }
        
        /* Check whether there are /any/ patches for this symbol */
        if (patches.count(sp.name().symbol()) == 0)
            return;
        
        /* Fetch the patches and apply /all/ patches the match; this ensures that patches added later take priority. */
        for (auto &&patch : patches.at(sp.name().symbol())) {
            /* Skip non-matching patches */
            if (!std::get<0>(patch).match(sp.name()))
                continue;
            
            /* Apply matching patches */
            auto patchValue = std::get<1>(patch);
            uintptr_t *target = (uintptr_t *) sp.bind_address();
            if (*target != patchValue) {
                *target = patchValue;
            }
        }
        
    });
    
}

/**
 * Perform dyld-compatible symbol rebinding of all references to @a symbol defined by @a library across all current
 * and future loaded images.
 *
 * @param symbol The name of the symbol to patch.
 * @param library The install name (e.g. '/System/Library/Frameworks/Foundation.framework/Versions/C/Foundation') of
 * the library responsible for exporting the original symbol.
 * @param replacementAddress The new address to which the symbol will be bound.
 */
- (void) rebindSymbol: (NSString *) symbol fromImage: (NSString *) library replacementAddress: (uintptr_t) replacementAddress {
    using namespace std;
    std::map<std::string, std::vector<std::tuple<SymbolName, uintptr_t>>> foo;
    
    auto symbolName = SymbolName(library.UTF8String, symbol.UTF8String);
    auto patchEntry = make_tuple(symbolName, replacementAddress);
    
    /* Add to the standard patch table */
    OSSpinLockLock(&_lock);
    if (_symbolPatches.count(symbolName.symbol()) == 0) {
        _symbolPatches.emplace(make_pair(symbolName.symbol(), vector<tuple<SymbolName, uintptr_t>> { patchEntry }));
    } else {
        _symbolPatches.at(symbolName.symbol()).push_back(patchEntry);
    }
    
    /* Mock up a patch table and use it to apply the patch to all existing images */
    auto patchTable = PatchTable();
    patchTable.emplace(make_pair(symbolName.symbol(), vector<tuple<SymbolName, uintptr_t>> { patchEntry }));
    
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const char *name = _dyld_get_image_name(i);
        perform_dyld_rebinding(patchTable, name, _dyld_get_image_header(i));
    }
    OSSpinLockUnlock(&_lock);
}

/**
 * Perform dyld-compatible symbol rebinding of all references to @a symbol defined by *any* library across all current
 * and future loaded images.
 *
 * This is essentially equivalent to single-level namespace symbol binding.
 *
 * @param symbol The name of the symbol to patch.
 * @param replacementAddress The new address to which
 */
- (void) rebindSymbol: (NSString *) symbol replacementAddress: (uintptr_t) replacementAddress {
    [self rebindSymbol: symbol fromImage: @"" replacementAddress: replacementAddress];
}


@end