// KKShadersPlus URP - Common utilities and URP compatibility
// This file provides compatibility between Built-in RP and URP

#ifndef KKP_COMMON_URP
#define KKP_COMMON_URP

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/SpaceTransforms.hlsl"

// URP compatibility macros for Built-in RP functions
#define UnityObjectToWorldNormal(normal) TransformObjectToWorldNormal(normal)
#define UnityObjectToWorldDir(dir) TransformObjectToWorldDir(dir)
#define UnityObjectToClipPos(pos) TransformObjectToHClip(pos)
#define UnityWorldToClipPos(pos) TransformWorldToHClip(pos)

// Matrix aliases
#define UNITY_MATRIX_VP GetWorldToHClipMatrix()
#define unity_ObjectToWorld GetObjectToWorldMatrix()
#define unity_WorldToObject GetWorldToObjectMatrix()
#define unity_WorldTransformParams GetOddNegativeScale()

// Camera and projection
#define _WorldSpaceCameraPos GetCameraPositionWS()
#define _ProjectionParams unity_OrthoParams

// UnpackNormal for URP
float3 UnpackScaleNormalURP(float4 packednormal, float scale)
{
    float3 normal;
    normal.xy = (packednormal.xy * 2 - 1) * scale;
    normal.z = sqrt(1.0 - saturate(dot(normal.xy, normal.xy)));
    return normal;
}

#define UnpackScaleNormal(packed, scale) UnpackScaleNormalURP(packed, scale)

// BlendNormals utility
float3 BlendNormals(float3 n1, float3 n2)
{
    return normalize(float3(n1.xy + n2.xy, n1.z * n2.z));
}

// Cubemap sampling (URP equivalent)
#define UNITY_SAMPLE_TEXCUBE_LOD(tex, dir, lod) SAMPLE_TEXTURECUBE_LOD(tex, sampler##tex, dir, lod)
#define unity_SpecCube0 unity_SpecCube0
#define unity_SpecCube0_HDR unity_SpecCube0_HDR
#define UNITY_SPECCUBE_LOD_STEPS 6

#define DecodeHDR(data, hdr) DecodeHDREnvironment(data, hdr)

#endif
