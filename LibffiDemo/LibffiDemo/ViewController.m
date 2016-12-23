//
//  ViewController.m
//  LibffiDemo
//
//  Created by AugustRush on 6/28/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "ffi.h"
#include <stdio.h>
#import <objc/message.h>

@interface ViewController ()

@property (nonatomic, copy) void(^testBlock)(NSString *test);

@end

@implementation ViewController

CGRect test1(char *c, CGRect b) {
    NSLog(@"c is %s b is %@",c,NSStringFromCGRect(b));
    return b;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self callCMethod];
//    [self callObjectCMethod];
//    [self callObjectCBlock];
//    [self callCreateObject];
//    [self testPresentViewController];
//    [self testAddMethod];
    [self testAllMethod];
}

- (ffi_type *)ffiStructTypeWithElementsCount:(NSUInteger)count {
    NSUInteger element_count = count;
    
    
    ffi_type** ffi_type_struct_element = malloc(sizeof(ffi_type*) * (element_count + 1));
    
    for(int idx = 0 ; idx < element_count ; idx++){
        
        ffi_type_struct_element[idx] = &ffi_type_double;
        
    }
    
    ffi_type_struct_element[element_count] = NULL;
    
    
    ffi_type* ffi_type_struct_ptr = malloc(sizeof(ffi_type));
    
    ffi_type_struct_ptr->size = 0;
    
    ffi_type_struct_ptr->alignment = 0;
    
    ffi_type_struct_ptr->type = FFI_TYPE_STRUCT;
    
    ffi_type_struct_ptr-> elements = ffi_type_struct_element;
    
    return ffi_type_struct_ptr;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)outputString:(NSString *)string {
    NSLog(@"just oc method %@",string);
}

- (id)createAnObject:(Class)class {
    id test = [[class alloc] init];
    return test;
}

- (NSInteger)addA:(NSInteger)a b:(NSInteger)b {
    return a + b;
}


- (void)callCMethod {
    ffi_cif cif;
    ffi_type *rect = [self ffiStructTypeWithElementsCount:4];
    ffi_type *args[2] = {&ffi_type_pointer,rect};
    char *s;
    CGRect varg1 = CGRectZero;
    void *values[2];
    CGRect * rv = (CGRect *)alloca(sizeof(CGRect));
    values[0] = &s;
    values[1] = &varg1;
    
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 2, rect, args);
    if (status == FFI_OK) {
        s = "asdfghjkl";
        varg1 = CGRectMake(300, 100, 300, 400);
        ffi_call(&cif, (void *)test1, (void *)rv, values);
    }
}

- (void)callObjectCMethod {
    ffi_cif cif;
    ffi_type *args[3] = {&ffi_type_pointer,&ffi_type_pointer,&ffi_type_pointer};
    NSString *s = @"jahsdfjhasdkjfh";
    void *values[3] = {(__bridge void *)self, 0,&s};
    void *rv = NULL;
    
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 3, &ffi_type_void, args);
    if (status == FFI_OK) {
        IMP imp = class_getMethodImplementation([self class], @selector(outputString:));
        values[1] = &imp;
        ffi_call(&cif, (void *)imp, rv, values);
    }
}

- (void)callObjectCBlock {
    
    [self setTestBlock:^(NSString *text) {
        NSLog(@"text is %@",text);
    }];
    
    ffi_cif cif;
    ffi_type *args[1] = {&ffi_type_pointer};
    NSString *test = @"test string!!!";
    void *paramaters[1] = {&test};
    void *returnValue = NULL;
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 1, &ffi_type_void, args);
    if (status == FFI_OK) {
        IMP imp = imp_implementationWithBlock(self.testBlock);
        ffi_call(&cif, (void *)imp, returnValue, paramaters);
    }
}

- (void)callCreateObject {
    ffi_cif cif;
    ffi_type *args[3] = {&ffi_type_pointer,&ffi_type_pointer,&ffi_type_pointer};
    Class class = [UIView class];
    void *values[3] = {(__bridge void *)self, 0,&class};
    void *rv = malloc(sizeof(class)) ;
    
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 3, &ffi_type_pointer, args);
    if (status == FFI_OK) {
        IMP imp = class_getMethodImplementation(object_getClass(self), @selector(createAnObject:));
        values[1] = &imp;
        ffi_call(&cif, (void *)imp, rv, values);
    }

    
    __unsafe_unretained id returnValue = (__bridge id)(*(void**)rv);
    free(rv);
    NSLog(@"return value is %@",returnValue);
}

- (UIViewController *)testPresentViewController {
    ffi_cif cif;
    ffi_type *args[2] = {&ffi_type_pointer,&ffi_type_pointer};
    Class class = [UIViewController class];
    void *paramaters[1] = {&class};
    size_t size = sizeof(class);
    void *returnV = alloca(size);
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 2, &ffi_type_pointer, args);
    if (status == FFI_OK) {
        IMP imp = class_getMethodImplementation(object_getClass(class), @selector(alloc));
        ffi_call(&cif, (void *)imp, returnV, paramaters);
    }
    __unsafe_unretained id returnValue = (__bridge id)alloca(size);//(__bridge id)(*(void**)returnV);
    memcpy(&returnValue, (void **)returnV, size);
    NSLog(@"alloc after is %@",returnValue);
    return returnValue;
}

- (void)testAddMethod {
    ffi_cif cif;
    ffi_type *args[4] = {&ffi_type_pointer,&ffi_type_pointer,&ffi_type_uint64,&ffi_type_uint64};
    NSUInteger a = 10;
    NSUInteger b = 100;
    void *paramaters[4] = {(__bridge void *)self,0,&a,&b};
    void *returnV = alloca(sizeof(NSUInteger));
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 4, &ffi_type_uint64, args);
    if (status == FFI_OK) {
        IMP imp = class_getMethodImplementation([self class], @selector(addA:b:));
        paramaters[1] = imp;
        ffi_call(&cif, (void *)imp, returnV, paramaters);
    }
    NSUInteger returnValue = (NSUInteger)alloca(sizeof(NSUInteger));
    memcpy(&returnValue, (void **)returnV, sizeof(NSUInteger));//(NSInteger)(*(void**)returnV);
    NSLog(@"alloc after is %ld",returnValue);
}

- (void)testAllMethod {

}


@end
