//
//  BSJavaScriptBridge.m
//  SwiftComplierDemo
//
//  Created by AugustRush on 12/3/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "BSJavaScriptBridge.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ffi.h"

NSString *const BSRegisteClassBlockJavaScriptName = @"_bs_registeClass";
NSString *const BSCreateObjectBlockJavaScriptName = @"_bs_createObject";
NSString *const BSFunctionObjcNameKey = @"objcName";
NSString *const BSFunctionTypeKey = @"type";
NSString *const BSFunctionJSNameKey = @"jsName";
NSString *const BSFunctionObjcEncodeKey = @"objcEncode";
NSString *const BSFunctionArgsCountKey = @"argsCount";

@interface BSJavaScriptBridge ()

@property (nonatomic, strong) JSContext *context;

@end

@implementation BSJavaScriptBridge

+ (instancetype)sharedInstance {
    static BSJavaScriptBridge *bridge = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bridge = [[BSJavaScriptBridge alloc] init];
    });
    
    return bridge;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _setUp];
    }
    return self;
}

#pragma mark - Private methods

- (void)_setUp {
    _context = [[JSContext alloc] init];
    
    [_context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"current context is %@, value is %@",context,value);
    }];
    
    __weak typeof(_context) wcontext = _context;
    id(^registeClass)(NSString *,NSString *, JSValue *) = ^id(NSString *name,NSString *superName, JSValue *funcsValue) {
        Class superClass = NSClassFromString(superName);
        Class class = objc_allocateClassPair(superClass, [name UTF8String], 0);
        objc_registerClassPair(class);
        NSArray<NSDictionary *> *funcs = [funcsValue toArray];
        NSLog(@"name is %@, superName is %@, funs is %@",name,superName,funcs);
        for (NSDictionary *dict in funcs) {
            NSString *methodName = dict[BSFunctionObjcNameKey];
            const char *typesC = [dict[BSFunctionObjcEncodeKey] UTF8String];
            NSUInteger argsCount = [dict[BSFunctionArgsCountKey] integerValue];
            // build imp
//            void* methodImp = NULL;
//            ffi_closure * closure = ffi_closure_alloc(sizeof(ffi_closure), (void**)&methodImp);
//            ffi_cif* cif = malloc(sizeof(ffi_cif));
//            ffi_type **args = malloc(sizeof(ffi_type) * argsCount);
//            for (int i = 0; i < argsCount; i++) {
//                const char encode = typesC[i+3];
//                ffi_type *type = [self argTypeWithEncodeChar:encode];
//                args[i] = type;
//            }
            NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:typesC];
            SEL selector = NSSelectorFromString(methodName);
            IMP implimention = method_getImplementation(<#Method m#>)
            class_addMethod(class, NSSelectorFromString(methodName), (IMP)_methodInterfaceBridge, typesC);
        }
        return class;
    };
    _context[BSRegisteClassBlockJavaScriptName] = registeClass;
    
    id(^createObject)(JSValue *,JSValue *) = ^id(JSValue *classValue,JSValue *selectorValue) {
//        Class class = classValue.toObject;
//        NSString *selectorName = selectorValue.toString;
//        SEL selector = NSSelectorFromString(selectorName);
//        id target = objc_msgSend([class alloc],selector,nil);
//        NSLog(@"name is %@, superName is %@",target,selectorValue);
        return nil;
    };
    _context[BSCreateObjectBlockJavaScriptName] = createObject;
}

void * _methodInterfaceBridge(id target, SEL sel, ...) {
    
    return 0;
}

- (ffi_type *)argTypeWithEncodeChar:(const char)encode {

    switch (encode) {
        case 'v':
            return &ffi_type_void;
        case 'c':
            return &ffi_type_schar;
        case 'C':
            return &ffi_type_uchar;
        case 's':
            return &ffi_type_sshort;
        case 'S':
            return &ffi_type_ushort;
        case 'i':
            return &ffi_type_sint;
        case 'I':
            return &ffi_type_uint;
        case 'l':
            return &ffi_type_slong;
        case 'L':
            return &ffi_type_ulong;
        case 'q':
            return &ffi_type_sint64;
        case 'Q':
            return &ffi_type_uint64;
        case 'f':
            return &ffi_type_float;
        case 'd':
            return &ffi_type_double;
        case 'B':
            return &ffi_type_uint8;
        case '^':
            return &ffi_type_pointer;
        case '@':
            return &ffi_type_pointer;
        case '#':
            return &ffi_type_pointer;
    }
    return NULL;
}

@end
