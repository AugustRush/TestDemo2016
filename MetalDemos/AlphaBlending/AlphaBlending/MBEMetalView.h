//
//  MBEMetalView.h
//  AlphaBlending
//
//  Created by Warren Moore on 11/7/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import UIKit;
@import QuartzCore.CAMetalLayer;

@interface MBEMetalView : UIView

@property (nonatomic, readonly) CAMetalLayer *metalLayer;
@property (nonatomic, readonly) UITouch *currentTouch;

@end
