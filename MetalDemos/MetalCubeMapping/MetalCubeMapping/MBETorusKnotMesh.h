//
//  TorusKnotGeometry.h
//  MetalCubeMapping
//
//  Created by Warren Moore on 11/10/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

#import "MBEMesh.h"
@import Metal;

@interface MBETorusKnotMesh : MBEMesh

/// `parameters` must be an NSArray containing two co-prime integers p, q, wrapped as NSNumbers.
- (instancetype)initWithParameters:(NSArray *)parameters
                        tubeRadius:(CGFloat)tubeRadius
                      tubeSegments:(NSInteger)segments
                        tubeSlices:(NSInteger)slices
                            device:(id<MTLDevice>)device;

@end
