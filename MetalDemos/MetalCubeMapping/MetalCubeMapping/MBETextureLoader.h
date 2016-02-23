//
//  MBETextureLoader.h
//  MetalCubeMapping
//
//  Created by Warren Moore on 11/7/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import UIKit;
@import Metal;

@interface MBETextureLoader : NSObject

+ (id<MTLTexture>)texture2DWithImageNamed:(NSString *)imageName device:(id<MTLDevice>)device;

+ (id<MTLTexture>)textureCubeWithImagesNamed:(NSArray *)imageNameArray device:(id<MTLDevice>)device;

@end
