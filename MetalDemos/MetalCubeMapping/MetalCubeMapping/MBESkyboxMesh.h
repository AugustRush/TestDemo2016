//
//  MBESkyboxGeometry.h
//  MetalCubeMapping
//
//  Created by Warren Moore on 11/8/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

#import "MBEMesh.h"
@import Metal;

@interface MBESkyboxMesh : MBEMesh

- (instancetype)initWithDevice:(id<MTLDevice>) device;

@end
