//
//  CSSLayoutView.m
//  CssLayoutDemo
//
//  Created by AugustRush on 11/4/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "CSSLayoutView.h"

@implementation CSSLayoutView

- (void)setCss_usesFlexbox:(BOOL)css_usesFlexbox {
    [super css_setUsesFlexbox:css_usesFlexbox];
}

- (void)setCss_direction:(NSUInteger)css_direction{
    [super css_setDirection:css_direction];
}

- (void)setCss_width:(CGFloat)css_width {
    [super css_setWidth:css_width];
}

- (void)setCss_alignItems:(NSUInteger)css_alignItems {
    [super css_setAlignItems:css_alignItems];
}

- (void)setCss_alignContent:(NSUInteger)css_alignContent {
    [super css_setAlignContent:css_alignContent];
}

- (void)setCss_justifyContent:(NSUInteger)css_justifyContent {
    [super css_setJustifyContent:css_justifyContent];
}

- (void)setCss_flexDirection:(NSUInteger)css_flexDirection {
    [super css_setFlexDirection:css_flexDirection];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [super css_applyLayout];
}

@end
