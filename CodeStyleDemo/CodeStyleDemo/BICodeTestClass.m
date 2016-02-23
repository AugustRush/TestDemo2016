//
//  BICodeTestClass.m
//  CodeStyleDemo
//
//  Created by AugustRush on 15/10/8.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import "BICodeTestClass.h"

@implementation BICodeTestClass


- (BOOL)doSomethingWithParamaA:(NSString *)paramaA paramaB:(int)paramaB {
    BOOL testVar = YES;///< an varible 
    NSLog(@"paramaA is %@, paramaB is %d",paramaA,paramaB);
    return testVar;
}

@end
