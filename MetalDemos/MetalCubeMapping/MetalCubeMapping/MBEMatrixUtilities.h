//
//  MBEMatrixUtilities.h
//  MetalCubeMapping
//
//  Created by Warren Moore on 11/10/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

@import simd;

matrix_float4x4 identity();

matrix_float4x4 rotation_about_axis(vector_float3 axis, float angle);

matrix_float4x4 translation(vector_float4 t);

matrix_float4x4 perspective_projection(float aspect, float fovy, float near, float far);

matrix_float3x3 upper_left3x3(const matrix_float4x4 mat4x4);
