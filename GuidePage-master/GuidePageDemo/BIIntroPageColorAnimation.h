//
//  BIIntroPageColorAnimation.h
//  GuidePageDemo
//
//  Created by AugustRush on 15/11/4.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import "BIIntroPageAnimation.h"

@interface BIIntroPageColorAnimation : BIIntroPageAnimation

- (instancetype)initWithView:(UIView *)view;

- (void)addColor:(UIColor *)color forKeyTime:(CGFloat)keyTime;
- (void)addColor:(UIColor *)color forKeyTime:(CGFloat)keyTime easing:(BIEasingCurve)easing;
- (void)addColors:(NSArray<UIColor *> *)colors forKeyTimes:(NSArray<NSNumber *> *)keyTimes;

@end
