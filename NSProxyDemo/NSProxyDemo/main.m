//
//  main.m
//  NSProxyDemo
//
//  Created by AugustRush on 1/30/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestProxy.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSMutableArray *array = @[].mutableCopy;
        TestProxy *proxy = [[TestProxy alloc] initWithObject:array];
        [(NSMutableArray *)proxy addObject:@"test"];
    }
    return 0;
}
