//
//  TestProxy.h
//  NSProxyDemo
//
//  Created by AugustRush on 1/30/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestProxy : NSProxy

- (instancetype)initWithObject:(id)object;

@end
