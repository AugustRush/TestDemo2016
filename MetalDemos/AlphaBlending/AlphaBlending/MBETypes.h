//
//  MBETypes.h
//  AlphaBlending
//
//  Created by Warren Moore on 11/10/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

#import <simd/simd.h>

typedef uint16_t MBEIndexType;

typedef struct
{
    matrix_float4x4 viewProjectionMatrix;
} Uniforms;

typedef struct
{
    matrix_float4x4 modelMatrix;
    matrix_float4x4 normalMatrix;
} InstanceUniforms;

typedef struct
{
    packed_float4 position;
    packed_float4 normal;
    packed_float4 diffuseColor;
    packed_float2 texCoords;
} MBEVertex;
