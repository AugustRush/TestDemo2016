//
//  MBECow.h
//  InstancedDrawing
//
//  Created by Warren Moore on 12/7/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import Foundation;
@import simd;

@interface MBECow : NSObject
@property (nonatomic, assign) vector_float3 position;
@property (nonatomic, assign) float targetHeading;
@property (nonatomic, assign) float heading;
@end
