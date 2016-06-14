//
//  JSOCTestModel.m
//  JSCoreOC
//
//  Created by AugustRush on 6/5/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "JSOCTestModel.h"

@implementation JSOCTestModel


- (NSInteger)add:(NSInteger)a b:(NSInteger)b {
     return a + b;
}

+ (instancetype)newObject:(NSInteger)mask {
    JSOCTestModel *model = [[JSOCTestModel alloc] init];
    return model;
}

@end