//
//  BIIntroPageColorAnimation.m
//  GuidePageDemo
//
//  Created by AugustRush on 15/11/4.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import "BIIntroPageColorAnimation.h"
#import "BIIntroPageFilmStrip.h"

@implementation BIIntroPageColorAnimation

- (instancetype)initWithView:(UIView *)view {
    return [super initWithAnimatedObject:view type:BIIntroPageAnimationTypeViewColor];
}

#pragma mark - public methods

- (void)addColor:(UIColor *)color forKeyTime:(CGFloat)keyTime {
    [self addValue:color forKeyTime:keyTime];
}

- (void)addColor:(UIColor *)color forKeyTime:(CGFloat)keyTime easing:(BIEasingCurve)easing {
    [self addValue:color forKeyTime:keyTime easing:easing];
}

- (void)addColors:(NSArray<UIColor *> *)colors forKeyTimes:(NSArray<NSNumber *> *)keyTimes {
    [self addValues:colors forKeyTimes:keyTimes];
}

@end
