//
//  MBERenderer.h
//  MetalCubeMapping
//
//  Created by Warren Moore on 11/7/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import UIKit;
@import QuartzCore.CAMetalLayer;
@import Metal;
@import simd;

@interface MBERenderer : NSObject

@property (nonatomic, strong) id<MTLDevice> device;
@property (nonatomic, strong) CAMetalLayer *layer;

@property (nonatomic, assign) BOOL useRefractionMaterial;
@property (nonatomic, assign) matrix_float4x4 sceneOrientation;

- (instancetype)initWithLayer:(CAMetalLayer *)layer;
- (void)draw;

@end
