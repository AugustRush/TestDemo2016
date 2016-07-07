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

void test1(char *c, int b) {
    printf("c is %s b is %d",c,b);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self callCMethod];
//    [self callObjectCMethod];
//    [self callObjectCBlock];
//    [self callCreateObject];
//    [self testPresentViewController];
//    [self testAddMethod];
    [self testAllMethod];
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
    ffi_type *args[2] = {&ffi_type_pointer,&ffi_type_uint32};
    char *s;
    int varg1 = 10;
    void *values[2];
    void *rv = NULL;
    values[0] = &s;
    values[1] = &varg1;
    
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 2, &ffi_type_void, args);
    if (status == FFI_OK) {
        s = "asdfghjkl";
        varg1 = 100;
        ffi_call(&cif, (void *)test1, rv, values);
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
