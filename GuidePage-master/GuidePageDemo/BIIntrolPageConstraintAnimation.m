//
//  BIIntrolPageConstraintAnimation.m
//  GuidePageDemo
//
//  Created by AugustRush on 15/11/2.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import "BIIntrolPageConstraintAnimation.h"
#import "BIIntroPageFilmStrip.h"

@implementation BIIntrolPageConstraintAnimation

- (instancetype)initWithConstraint:(NSLayoutConstraint *)constraint {
    return [super initWithAnimatedObject:constraint type:BIIntroPageAnimationTypeConstraint];
}

#pragma mark - public methods

- (void)addConstant:(CGFloat)constant forKeyTime:(CGFloat)keyTime {
    [self addValue:@(constant) forKeyTime:keyTime];
}

- (void)addConstant:(CGFloat)constant forKeyTime:(CGFloat)keyTime easing:(BIEasingCurve)easing {
    [self addValue:@(constant) forKeyTime:keyTime easing:easing];
}

- (void)addConstants:(NSArray<NSNumber *> *)constants forKeyTimes:(NSArray<NSNumber *> *)keyTimes {
    [self addValues:constants forKeyTimes:keyTimes];
}

@end
