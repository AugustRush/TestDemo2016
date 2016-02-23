//
//  BICodeTestClass+BITestExtension.m
//  CodeStyleDemo
//
//  Created by AugustRush on 15/10/8.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import "BICodeTestClass+BITestExtension.h"

@implementation BICodeTestClass (BITestExtension)

- (NSString *)aTestExtenionMethod_biex {
    return NSStringFromSelector(_cmd);
}

@end
