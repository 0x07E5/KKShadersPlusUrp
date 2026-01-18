// KKShadersPlus URP - Hair Lighting
// URP Version

#ifndef KKP_HAIR_LIGHTING_URP
#define KKP_HAIR_LIGHTING_URP

float GetLambert(float3 lightDir, float3 normal) {
    return max(dot(lightDir, normal), 0.0);
}

// Shadows - URP version
float GetShadowAttenuationHair(Varyings i, float vertexLightingShadowAtten, float3 normal, float3 worldLightDir, float3 viewDir, float4 shadowCoord) {
    // Normal adjustment for the face
    float3 viewNorm = viewDir - normal;
    float2 normalMaskUV = i.uv0 * _NormalMask_ST.xy + _NormalMask_ST.zw;
    float3 normalMask = SAMPLE_TEX2D(_NormalMask, normalMaskUV).rgb;
    normalMask.xy = normalMask.yz * float2(_FaceNormalG, _FaceShadowG);
    viewNorm = normalMask.x * viewNorm + normal;
    float maskG = max(normalMask.g, 1.0);
    
#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
    float shadowAttenuation = MainLightRealtimeShadow(shadowCoord);
    shadowAttenuation = saturate(shadowAttenuation * 2.0 - 1.0);
    shadowAttenuation = max(shadowAttenuation, normalMask.y);
#else
    float shadowAttenuation = maskG;
#endif

    float shadowAttenLambert = _UseRampForShadows ? shadowAttenuation : 1;
    float rampAtten = _UseRampForShadows ? 1 : shadowAttenuation;

    float lambertShadows = GetLambert(worldLightDir, normal) * shadowAttenLambert;
    float vertexShadows = vertexLightingShadowAtten;
    float blendShadows = max(vertexShadows, lambertShadows);
    float2 rampUV = blendShadows * _RampG_ST.xy + _RampG_ST.zw;
    float ramp = SAMPLE_TEX2D(_RampG, rampUV).x * rampAtten;

    return ramp;
}

#endif
