//
//  MBEGeometry.h
//  Mipmapping
//
//  Created by Warren Moore on 11/10/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import UIKit;
@import Metal;

#import "MBETypes.h"

@interface MBEMesh : NSObject

@property (nonatomic, readonly) id<MTLBuffer> vertexBuffer;
@property (nonatomic, readonly) id<MTLBuffer> indexBuffer;

@end
