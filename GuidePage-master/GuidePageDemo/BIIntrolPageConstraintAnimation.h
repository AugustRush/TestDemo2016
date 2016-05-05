//
//  BIIntrolPageConstraintAnimation.h
//  GuidePageDemo
//
//  Created by AugustRush on 15/11/2.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import "BIIntroPageAnimation.h"

@interface BIIntrolPageConstraintAnimation : BIIntroPageAnimation

- (instancetype)initWithConstraint:(NSLayoutConstraint *)constraint;

- (void)addConstant:(CGFloat)constant forKeyTime:(CGFloat)keyTime;
- (void)addConstant:(CGFloat)constant forKeyTime:(CGFloat)keyTime easing:(BIEasingCurve)easing;
- (void)addConstants:(NSArray<NSNumber *> *)constants forKeyTimes:(NSArray<NSNumber *> *)keyTimes;

@end
