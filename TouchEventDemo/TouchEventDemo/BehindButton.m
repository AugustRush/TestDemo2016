//
//  BehindButton.m
//  TouchEventDemo
//
//  Created by AugustRush on 3/16/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "BehindButton.h"

@implementation BehindButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@ %@",NSStringFromClass([self class]),NSStringFromCGPoint(point));
    return [super pointInside:point withEvent:event];
}

@end
