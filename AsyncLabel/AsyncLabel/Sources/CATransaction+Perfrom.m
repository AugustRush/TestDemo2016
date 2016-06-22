//
//  Perform.m
//  AsyncLabel
//
//  Created by AugustRush on 6/16/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "CATransaction+Perfrom.h"

@implementation CATransaction(Perfrom)

+ (void)perform:(void (^)())perform {
    [self lock];
    [self begin];
    perform();
    [self commit];
    [self unlock];
}

@end
