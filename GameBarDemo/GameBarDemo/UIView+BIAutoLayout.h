//
//  UIView+BIAutoLayout.h
//  GuidePageDemo
//
//  Created by AugustRush on 15/11/12.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BILayoutAttribute) {
  BILayoutAttributeCenterX = NSLayoutAttributeCenterX,
  BILayoutAttributeCenterY = NSLayoutAttributeCenterY,
  BILayoutAttributeLeft = NSLayoutAttributeLeft,
  BILayoutAttributeRight = NSLayoutAttributeRight,
  BILayoutAttributeTop = NSLayoutAttributeTop,
  BILayoutAttributeBottom = NSLayoutAttributeBottom
};

@interface UIView (BIAutoLayout)

- (NSLayoutConstraint *)anchorCenterXToSuperView;
- (NSLayoutConstraint *)anchorCenterYToSuperView;
- (NSLayoutConstraint *)anchorCenterXToSuperViewWithMutiplier:
    (CGFloat)multiplier;
- (NSLayoutConstraint *)anchorCenterYToSuperViewWithMutiplier:
    (CGFloat)multiplier;
- (NSArray<NSLayoutConstraint *> *)anchorCenterToSuperView;

- (NSLayoutConstraint *)autoSetWidth:(CGFloat)width;
- (NSLayoutConstraint *)autoSetHeight:(CGFloat)height;
- (NSArray<NSLayoutConstraint *> *)autoSetSize:(CGSize)size;

- (NSLayoutConstraint *)makeWidthEqual:(UIView *)view;
- (NSLayoutConstraint *)makeWidthEqual:(UIView *)view mutiplier:(CGFloat)mutiplier;
- (NSLayoutConstraint *)makeWidthEqual:(UIView *)view mutiplier:(CGFloat)mutiplier constant:(CGFloat)constant;
- (NSLayoutConstraint *)makeHeightEqual:(UIView *)view;
- (NSLayoutConstraint *)makeHeightEqual:(UIView *)view mutiplier:(CGFloat)mutiplier;
- (NSLayoutConstraint *)makeHeightEqual:(UIView *)view mutiplier:(CGFloat)mutiplier constant:(CGFloat)constant;

- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                   toSuperView:(BILayoutAttribute)toPosition;
- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                   toSuperView:(BILayoutAttribute)toPosition
                      constant:(CGFloat)constant;

- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                        toView:(UIView *)view
                    toPosition:(BILayoutAttribute)toPosition
                    multiplier:(CGFloat)multiplier;
- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                        toView:(UIView *)view
                    toPosition:(BILayoutAttribute)toPosition
                      constant:(CGFloat)constant;

- (NSLayoutConstraint *)makeAttribute:(NSLayoutAttribute)attribute
                               toView:(UIView *)view
                          toAttribute:(NSLayoutAttribute)toAttribute
                           multiplier:(CGFloat)multiplier
                             constant:(CGFloat)constant;

@end
