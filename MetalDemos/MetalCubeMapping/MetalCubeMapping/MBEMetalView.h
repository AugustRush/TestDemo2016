//
//  MBEMetalView.h
//  MetalCubeMapping
//
//  Created by Warren Moore on 11/7/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

#import <UIKit/UIKit.h>
@import QuartzCore.CAMetalLayer;

@interface MBEMetalView : UIView

@property (nonatomic, readonly) CAMetalLayer *metalLayer;

@end
