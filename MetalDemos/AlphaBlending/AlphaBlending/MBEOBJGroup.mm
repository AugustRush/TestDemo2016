//
//  MBEOBJGroup.m
//  InstancedDrawing
//
//  Created by Warren Moore on 9/28/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

#import "MBEOBJGroup.h"
#import "MBETypes.h"

@implementation MBEOBJGroup

- (instancetype)initWithName:(NSString *)name
{
    if ((self = [super init]))
    {
        _name = [name copy];
    }
    return self;
}

- (NSString *)description
{
    size_t vertCount = self.vertexData.length / sizeof(MBEVertex);
    size_t indexCount = self.indexData.length / sizeof(MBEIndexType);
    return [NSString stringWithFormat:@"<MBEOBJMesh %p> (\"%@\", %d vertices, %d indices)",
            self, self.name, (int)vertCount, (int)indexCount];
}

@end


