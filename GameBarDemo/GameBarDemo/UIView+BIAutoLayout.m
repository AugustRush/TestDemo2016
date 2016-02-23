//
//  UIView+BIAutoLayout.m
//  GuidePageDemo
//
//  Created by AugustRush on 15/11/12.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import "UIView+BIAutoLayout.h"

@implementation UIView (BIAutoLayout)

- (NSLayoutConstraint *)anchorCenterXToSuperView {
  return [self anchorCenterXToSuperViewWithMutiplier:1];
}

- (NSLayoutConstraint *)anchorCenterYToSuperView {
  return [self anchorCenterYToSuperViewWithMutiplier:1];
}

- (NSLayoutConstraint *)anchorCenterXToSuperViewWithMutiplier:
    (CGFloat)multiplier {
  NSAssert(self.superview, @"superView should not be nil!");
  return [self makeAttribute:NSLayoutAttributeCenterX
                      toView:self.superview
                 toAttribute:NSLayoutAttributeCenterX
                  multiplier:multiplier
                    constant:0];
}

- (NSLayoutConstraint *)anchorCenterYToSuperViewWithMutiplier:
    (CGFloat)multiplier {
  NSAssert(self.superview, @"superView should not be nil!");
  return [self makeAttribute:NSLayoutAttributeCenterY
                      toView:self.superview
                 toAttribute:NSLayoutAttributeCenterY
                  multiplier:multiplier
                    constant:0];
}

- (NSArray<NSLayoutConstraint *> *)anchorCenterToSuperView {
  return @[ [self anchorCenterXToSuperView], [self anchorCenterYToSuperView]];
}

- (NSLayoutConstraint *)autoSetWidth:(CGFloat)width {
  return [self makeAttribute:NSLayoutAttributeWidth
                      toView:nil
                 toAttribute:NSLayoutAttributeWidth
                    constant:width];
}

- (NSLayoutConstraint *)autoSetHeight:(CGFloat)height {
  return [self makeAttribute:NSLayoutAttributeHeight
                      toView:nil
                 toAttribute:NSLayoutAttributeWidth
                    constant:height];
}

- (NSArray<NSLayoutConstraint *> *)autoSetSize:(CGSize)size {
  return @[ [self autoSetWidth:size.width], [self autoSetHeight:size.height] ];
}

- (NSLayoutConstraint *)makeWidthEqual:(UIView *)view {
    return [self makeWidthEqual:view mutiplier:1];
}

- (NSLayoutConstraint *)makeWidthEqual:(UIView *)view mutiplier:(CGFloat)mutiplier {
    return [self makeWidthEqual:view mutiplier:mutiplier constant:0];
}

- (NSLayoutConstraint *)makeWidthEqual:(UIView *)view mutiplier:(CGFloat)mutiplier constant:(CGFloat)constant {
    NSAssert(view != nil, @"refrence view should not be nil!");
    return [self makeAttribute:NSLayoutAttributeWidth toView:view toAttribute:NSLayoutAttributeWidth multiplier:mutiplier constant:constant];
}

- (NSLayoutConstraint *)makeHeightEqual:(UIView *)view {
    return [self makeHeightEqual:view mutiplier:1];
}

- (NSLayoutConstraint *)makeHeightEqual:(UIView *)view mutiplier:(CGFloat)mutiplier {
    return [self makeHeightEqual:view mutiplier:mutiplier constant:0];
}

- (NSLayoutConstraint *)makeHeightEqual:(UIView *)view mutiplier:(CGFloat)mutiplier constant:(CGFloat)constant {
    return [self makeAttribute:NSLayoutAttributeHeight toView:view toAttribute:NSLayoutAttributeHeight multiplier:mutiplier constant:constant];
}

- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                   toSuperView:(BILayoutAttribute)toPosition {
  return [self anchor:position toSuperView:toPosition constant:0.0];
}

- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                   toSuperView:(BILayoutAttribute)toPosition
                      constant:(CGFloat)constant {
  NSAssert(self.superview, @"superView should not be nil!");
  return [self makeAttribute:(NSLayoutAttribute)position
                      toView:self.superview
                 toAttribute:(NSLayoutAttribute)toPosition
                    constant:constant];
}

- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                        toView:(UIView *)view
                    toPosition:(BILayoutAttribute)toPosition
                      constant:(CGFloat)constant {
  return [self makeAttribute:(NSLayoutAttribute)position
                      toView:view
                 toAttribute:(NSLayoutAttribute)toPosition
                    constant:constant];
}

- (NSLayoutConstraint *)anchor:(BILayoutAttribute)position
                        toView:(UIView *)view
                    toPosition:(BILayoutAttribute)toPosition
                    multiplier:(CGFloat)multiplier {
  return [self makeAttribute:(NSLayoutAttribute)position
                      toView:view
                 toAttribute:(NSLayoutAttribute)toPosition
                  multiplier:multiplier
                    constant:0];
}

- (NSLayoutConstraint *)makeAttribute:(NSLayoutAttribute)attribute
                               toView:(UIView *)view
                          toAttribute:(NSLayoutAttribute)toAttribute
                             constant:(CGFloat)constant {
  return [self makeAttribute:attribute
                      toView:view
                 toAttribute:toAttribute
                  multiplier:1
                    constant:constant];
}

- (NSLayoutConstraint *)makeAttribute:(NSLayoutAttribute)attribute
                               toView:(UIView *)view
                          toAttribute:(NSLayoutAttribute)toAttribute
                           multiplier:(CGFloat)multiplier
                             constant:(CGFloat)constant {
  self.translatesAutoresizingMaskIntoConstraints = NO;
  NSLayoutConstraint *constraint =
      [NSLayoutConstraint constraintWithItem:self
                                   attribute:attribute
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:view
                                   attribute:toAttribute
                                  multiplier:multiplier
                                    constant:constant];
  if (view != nil) {
    [self.superview addConstraint:constraint];
  } else {
    [self addConstraint:constraint];
  }
  return constraint;
}

@end
