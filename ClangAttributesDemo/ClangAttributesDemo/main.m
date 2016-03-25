//
//  main.m
//  ClangAttributesDemo
//
//  Created by AugustRush on 3/25/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>

//objc_boxable

struct __attribute__((objc_boxable)) some_struct {
    int i;
    float j;
    double k;
};

//objc_runtime_name
__attribute__((objc_runtime_name("TestMessage")))
@interface Message : NSObject

- (void)foo;

@end
@implementation Message

- (void)foo {
    NSLog(@"just foo");
}

@end

//overloadable

float __attribute__((overloadable)) tgsin(float x) { return sinf(x); }
double __attribute__((overloadable)) tgsin(double x) { return sin(x); }
long double __attribute__((overloadable)) tgsin(long double x) { return sinl(x); }



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //objc_boxable
        struct some_struct ss;
        ss.i = 1;
        ss.j = 2.0;
        ss.k = 3.00;
        NSValue *boxedSS = @(ss);
        
        NSLog(@"boxedSS is %@ boxedSS objCtype is %s",boxedSS,[boxedSS objCType]);
        
        Message *message = [[NSClassFromString(@"TestMessage") alloc] init];
        [message foo];
    }
    return 0;
}
