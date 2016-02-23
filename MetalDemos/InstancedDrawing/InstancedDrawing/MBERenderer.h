//
//  MBERenderer.h
//  InstancedDrawing
//
//  Created by Warren Moore on 12/3/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import Foundation;
@import QuartzCore.CAMetalLayer;

@interface MBERenderer : NSObject

@property (nonatomic, assign) float angularVelocity;
@property (nonatomic, assign) float velocity;
@property (nonatomic, assign) float frameDuration;

- (instancetype)initWithLayer:(CAMetalLayer *)layer;
- (void)draw;

@end
