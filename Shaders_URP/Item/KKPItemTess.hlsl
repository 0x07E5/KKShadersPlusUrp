
#ifndef KKP_ITEMTESS_URP
#define KKP_ITEMTESS_URP

// URP Core
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

#define NUM_BEZ_POINTS

struct TessellationControlPoint 
{
	float4 vertex : INTERNALTESSPOS;
    float4 posCS : CLIPPOS;
    float4 posWS : WORLDPOS;
	float3 normal : NORMAL;
	float4 tangent : TANGENT;
	float2 uv0 : TEXCOORD0;
};

struct TessellationFactors {
    float edge[3] : SV_TessFactor;
    float inside : SV_InsideTessFactor;
    float3 bezierPoints[7] : BEZIERPOS;
};

// Params
float _ShrinkVal;
float _ShrinkVerticalAdjust;
float _TessMax;
float _TessMin;
float _TessBias;
float _TessSmooth;
float _Tolerance;
DECLARE_TEX2D(_TessTex);

// Vertex Shader for Tessellation
TessellationControlPoint TessVert(VertexData v){
    TessellationControlPoint p;
    v.vertex.xyz *= _ShrinkVal;
    v.vertex.y += _ShrinkVerticalAdjust;
    p.vertex = v.vertex;
    p.posWS = mul(GetObjectToWorldMatrix(), v.vertex);
    p.posCS = TransformWorldToHClip(p.posWS.xyz);
    p.normal = v.normal;
    p.tangent = v.tangent;
    p.uv0 = v.uv0;
    return p;
}

bool ShouldBackFaceCull(float4 p0PositionCS, float4 p1PositionCS, float4 p2PositionCS) {
    float3 point0 = p0PositionCS.xyz / p0PositionCS.w;
    float3 point1 = p1PositionCS.xyz / p1PositionCS.w;
    float3 point2 = p2PositionCS.xyz / p2PositionCS.w;
    // In clip space, the view direction is float3(0, 0, 1), so we can just test the z coord
#if UNITY_REVERSED_Z
    return cross(point1 - point0, point2 - point0).z < -_Tolerance;
#else
    return cross(point1 - point0, point2 - point0).z > _Tolerance;
#endif
}

bool IsOutOfBounds(float3 p, float3 lower, float3 higher) {
    return p.x < lower.x || p.x > higher.x || p.y < lower.y || p.y > higher.y || p.z < lower.z || p.z > higher.z;
}

bool IsPointOutOfFrustum(float4 positionCS) {
    float3 culling = positionCS.xyz;
    float w = positionCS.w;
    float3 lowerBounds = float3(-w - _Tolerance, -w - _Tolerance, -w * 0 - _Tolerance);
    float3 higherBounds = float3(w + _Tolerance, w + _Tolerance, w + _Tolerance);
    return IsOutOfBounds(culling, lowerBounds, higherBounds);
}

bool ShouldClipPatch(float4 p0PositionCS, float4 p1PositionCS, float4 p2PositionCS) {
    bool allOutside = IsPointOutOfFrustum(p0PositionCS) && IsPointOutOfFrustum(p1PositionCS) && IsPointOutOfFrustum(p2PositionCS);
    bool backFace = ShouldBackFaceCull(p0PositionCS, p1PositionCS, p2PositionCS);
    return allOutside;
}

[domain("tri")]
[outputcontrolpoints(3)]
[outputtopology("triangle_cw")]
[partitioning("fractional_odd")]
[patchconstantfunc("patchFunc")]
TessellationControlPoint hull(InputPatch<TessellationControlPoint , 3> patch, uint id: SV_OUTPUTCONTROLPOINTID){
    return patch[id];
}

float EdgeTessellationFactor(float3 p0PositionWS, float2 p0UV, float3 p1PositionWS, float2 p1UV) {
    float length = distance(p0PositionWS, p1PositionWS) * _TessBias * 3;
    float distanceToCamera = distance(GetCameraPositionWS(), (p0PositionWS + p1PositionWS) * 0.5);
	
	float2 tessUV = (p0UV + p1UV) * 0.5;
	
    float tessTex = SAMPLE_TEX2D_LOD(_TessTex, float4(tessUV, 0, 0), 0).x;
    float factor = length / (distanceToCamera * distanceToCamera);
    factor = min(_TessMax, factor);
    float multiplier = 1.0;
    #ifdef TESS_MID
        multiplier = 0.35;
    #endif
    #ifdef TESS_LOW
        multiplier = 0.1;
    #endif
    return max(_TessMin, factor * tessTex * multiplier);
}

float3 CalculateBezierControlPoint(float3 p0PositionWS, float3 aNormalWS, float3 p1PositionWS, float3 bNormalWS) {
    float w = dot(p1PositionWS - p0PositionWS, aNormalWS);
    return (p0PositionWS * 2 + p1PositionWS - w * aNormalWS) / 3.0;
}

void CalculateBezierControlPoints(inout float3 bezierPoints[7],
    float3 p0PositionWS, float3 p0NormalWS, float3 p1PositionWS, float3 p1NormalWS, float3 p2PositionWS, float3 p2NormalWS) {
    bezierPoints[0] = CalculateBezierControlPoint(p0PositionWS, p0NormalWS, p1PositionWS, p1NormalWS);
    bezierPoints[1] = CalculateBezierControlPoint(p1PositionWS, p1NormalWS, p0PositionWS, p0NormalWS);
    bezierPoints[2] = CalculateBezierControlPoint(p1PositionWS, p1NormalWS, p2PositionWS, p2NormalWS);
    bezierPoints[3] = CalculateBezierControlPoint(p2PositionWS, p2NormalWS, p1PositionWS, p1NormalWS);
    bezierPoints[4] = CalculateBezierControlPoint(p2PositionWS, p2NormalWS, p0PositionWS, p0NormalWS);
    bezierPoints[5] = CalculateBezierControlPoint(p0PositionWS, p0NormalWS, p2PositionWS, p2NormalWS);
    float3 avgBezier = 0;
    [unroll] for (int i = 0; i < 6; i++) {
        avgBezier += bezierPoints[i];
    }
    avgBezier /= 6.0;
    float3 avgControl = (p0PositionWS + p1PositionWS + p2PositionWS) / 3.0;
    bezierPoints[6] = avgBezier + (avgBezier - avgControl) / 2.0;
}

TessellationFactors patchFunc(InputPatch<TessellationControlPoint , 3> patch){
    TessellationFactors f;
    if(ShouldClipPatch(patch[0].posCS, patch[1].posCS, patch[2].posCS)){
        f.edge[0] = 0;
        f.edge[1] = 0;
        f.edge[2] = 0;
        f.inside = 0;
    }
    else{
        f.edge[0] = EdgeTessellationFactor(patch[1].posWS, patch[1].uv0, patch[2].posWS, patch[2].uv0);
        f.edge[1] = EdgeTessellationFactor(patch[2].posWS, patch[2].uv0, patch[0].posWS, patch[0].uv0);
        f.edge[2] = EdgeTessellationFactor(patch[0].posWS, patch[0].uv0, patch[1].posWS, patch[1].uv0);
        f.inside = (f.edge[0] + f.edge[1] + f.edge[2]) / 3.0;
        CalculateBezierControlPoints(f.bezierPoints, patch[0].vertex.xyz, patch[0].normal, 
          patch[1].vertex.xyz, patch[1].normal, patch[2].vertex.xyz, patch[2].normal);
    }

    return f;
}

float3 PhongProjectedPosition(float3 flatPosition, float3 cornerPosition, float3 normal) {
    return flatPosition - dot(flatPosition - cornerPosition, normal) * normal;
}

float3 BarycentricInterpolate(float3 bary, float3 p0, float3 p1, float3 p2){
    return bary.x * p0 + bary.y * p1 +bary.z * p2;
}

float3 CalculatePhongPosition(float3 bary, float smoothing, float3 p0Position, float3 p0Normal,
    float3 p1Position, float3 p1Normal, float3 p2Position, float3 p2Normal) {
    float3 flatPosition = BarycentricInterpolate(bary, p0Position, p1Position, p2Position);
    float3 smoothedPosition =
        bary.x * PhongProjectedPosition(flatPosition, p0Position, p0Normal) +
        bary.y * PhongProjectedPosition(flatPosition, p1Position, p1Normal) +
        bary.z * PhongProjectedPosition(flatPosition, p2Position, p2Normal);
    return lerp(flatPosition, smoothedPosition, smoothing);
}

#define INTERPOLATE_TRI(param) data.param = patch[0].param * barycentricCoordinates.x + patch[1].param * barycentricCoordinates.y + patch[2].param * barycentricCoordinates.z;

#ifndef OUTPUT_TYPE
    #ifdef SHADOW_CASTER_PASS
       #define OUTPUT_TYPE ShadowVaryings
       #define VERT_FUNC ShadowVert
    #elif defined(DEPTH_ONLY_PASS)
       #define OUTPUT_TYPE DepthVaryings
       #define VERT_FUNC DepthVert
    #else
       #define OUTPUT_TYPE Varyings
       #define VERT_FUNC vert
    #endif
#endif

[domain("tri")]
OUTPUT_TYPE domain(TessellationFactors factors, OutputPatch<TessellationControlPoint , 3> patch, float3 barycentricCoordinates : SV_DomainLocation){
    VertexData data;
    float smoothing = _TessSmooth;
    float3 pos = CalculatePhongPosition(barycentricCoordinates, smoothing, 
      patch[0].vertex.xyz, patch[0].normal, 
      patch[1].vertex.xyz, patch[1].normal, 
      patch[2].vertex.xyz, patch[2].normal);
    data.vertex = float4(pos, 1);
    data.normal = patch[0].normal * barycentricCoordinates.x + patch[1].normal * barycentricCoordinates.y + patch[2].normal * barycentricCoordinates.z;
    
    // Tangent might be float4 in struct, but simple lerp works if components aligned.
    // However, tangent is float4, so lerp is fine.
    data.tangent = patch[0].tangent * barycentricCoordinates.x + patch[1].tangent * barycentricCoordinates.y + patch[2].tangent * barycentricCoordinates.z;

    INTERPOLATE_TRI(uv0);

    return VERT_FUNC(data);
}

#endif
