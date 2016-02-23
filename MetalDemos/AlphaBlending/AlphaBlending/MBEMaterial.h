//
//  MBEMaterial.h
//  AlphaBlending
//
//  Created by Warren Moore on 1/18/15.
//  Copyright (c) 2015 Metal By Example. All rights reserved.
//

@import Foundation;
@import Metal;
@import simd;

@interface MBEMaterial : NSObject

@property (nonatomic, strong) id<MTLRenderPipelineState> pipelineState;
@property (nonatomic, strong) id<MTLDepthStencilState> depthState;
@property (nonatomic, strong) id<MTLTexture> diffuseTexture;

- (instancetype)initWithDiffuseTexture:(id<MTLTexture>)diffuseTexture
                      alphaTestEnabled:(BOOL)alphaTestEnabled
                       blendingEnabled:(BOOL)blendingEnabled
                     depthWriteEnabled:(BOOL)depthWriteEnabled
                                device:(id<MTLDevice>)device;

@end
