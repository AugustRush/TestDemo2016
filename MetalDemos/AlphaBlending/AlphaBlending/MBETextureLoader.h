//
//  MBETextureLoader.h
//  InstancedDrawing
//
//  Created by Warren Moore on 11/7/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import UIKit;
@import Metal;

@interface MBETextureLoader : NSObject

+ (instancetype)sharedTextureLoader;

- (id<MTLTexture>)texture2DWithImageNamed:(NSString *)imageName
                                mipmapped:(BOOL)mipmapped
                                   device:(id<MTLDevice>)device;

@end
