//
//  CSSLayoutView.h
//  CssLayoutDemo
//
//  Created by AugustRush on 11/4/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CSSLayout.h"

IB_DESIGNABLE
@interface CSSLayoutView : UIView
@property (nonatomic, assign) IBInspectable BOOL css_usesFlexbox;
//@property (nonatomic, assign) IBInspectable NSUInteger css_direction;
//@property (nonatomic, assign) IBInspectable NSUInteger css_flexDirection;
//ı@property (nonatomic, assign) IBInspectable NSUInteger css_justifyContent;
//@property (nonatomic, assign) IBInspectable NSUInteger css_alignContent;
//@property (nonatomic, assign) IBInspectable NSUInteger css_alignItems;
@property (nonatomic, assign) IBInspectable CGFloat css_width;

@end
