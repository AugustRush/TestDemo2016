//
//  MBETypes.h
//  MetalCubeMapping
//
//  Created by Warren Moore on 11/10/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import simd;

typedef struct
{
    matrix_float4x4 modelMatrix;
    matrix_float4x4 projectionMatrix;
    matrix_float4x4 normalMatrix;
    matrix_float4x4 modelViewProjectionMatrix;
    vector_float4 worldCameraPosition;
} Uniforms;

typedef struct
{
    vector_float4 position;
    vector_float4 normal;
} Vertex;
