//
//  TestProxy.m
//  NSProxyDemo
//
//  Created by AugustRush on 1/30/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

#import "TestProxy.h"

@implementation TestProxy
{
    id _parentObject;
    NSMutableArray *_methodStartInterceptors;
    NSMutableArray *_methodEndInterceptors;
}

- (instancetype)initWithObject:(id)object {
    _parentObject = object;
    _methodEndInterceptors = @[].mutableCopy;
    _methodStartInterceptors = @[].mutableCopy;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
//    NSMethodSignature *signature = [NSMethodSignature ];
    return [[self class] instanceMethodSignatureForSelector:@selector(testAddObject:)];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *selectorName = NSStringFromSelector(invocation.selector);
    if ([selectorName isEqualToString:@"addObject:"]) {
        NSLog(@"test add object is start");
        //第一种方式
//        id paramater ;
//        [invocation getArgument:&paramater atIndex:2];
//        [self performSelector:@selector(testAddObject:) withObject:paramater];
        //第二种方式
        [invocation setSelector:@selector(testAddObject:)];
        [invocation invokeWithTarget:self];
    }
}

- (void)testAddObject:(id)object {
    NSLog(@"add object is %@",object);
    [_parentObject addObject:object];
}

- (void)test:(id)any {
    NSLog(@"what a fuck!!!");
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

@end
