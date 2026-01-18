// KKShadersPlus URP - Reflect
// URP Version

#ifndef KKP_REFLECT_URP
#define KKP_REFLECT_URP

float4 _ReflectCol;
float _ReflectColMix;
float _DisableShadowedMatcap;

float _Reflective;
float _ReflectiveBlend;
float _ReflectiveMulOrAdd;
float _ReflectiveOverlayed;

float _UseMatCapReflection;
DECLARE_TEX2D(_ReflectionMapCap);
float4 _ReflectionMapCap_ST;

float _ReflectRotation;
DECLARE_TEX2D_NOSAMPLER(_ReflectMapDetail);
float4 _ReflectMapDetail_ST;

#ifndef ROTATEUV
float2 rotateUV(float2 uv, float2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return float2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + pivot;
}
#endif

float3 GetBlendReflections(float2 uv, float3 diffuse, float3 normal, float3 viewDir, float metallicMap, float lightAmount = 1) {
    _ReflectiveBlend *= _ReflectCol.a;
    float4 reflectDetail = SAMPLE_TEX2D_SAMPLER(_ReflectMapDetail, _MainTex, (uv * _ReflectMapDetail_ST.xy) + _ReflectMapDetail_ST.zw);
    float reflectMap = reflectDetail.r;
    float reflectMask = reflectDetail.g;
    
    float3 reflectionDir = reflect(-viewDir, normal);
    float roughness = 1 - (metallicMap * _Reflective);
    roughness *= 1.7 - 0.7 * roughness;
    
    // URP reflection probe sampling
    float3 env = GlossyEnvironmentReflection(reflectionDir, roughness, 1.0) * _ReflectiveBlend;

    // Matcap using view-space normals
    float3 viewNormal = TransformWorldToViewNormal(normal);
    float2 matcapUV = viewNormal.xy * 0.5 * _ReflectionMapCap_ST.xy + 0.5 + _ReflectionMapCap_ST.zw;
    matcapUV = rotateUV(matcapUV, float2(0.5, 0.5), radians(_ReflectRotation));
    
    float4 matcap = SAMPLE_TEX2D(_ReflectionMapCap, matcapUV);
    matcap = pow(matcap, 0.454545) * _ReflectiveBlend;
    env = lerp(env, matcap.rgb, _UseMatCapReflection * reflectMask);
    env = lerp(env, env * _ReflectCol.rgb, _ReflectColMix);
    
    float matCapAttenuation = 1 - (1 - lightAmount) * _DisableShadowedMatcap;

    // Blending modes
    float3 envMul = (1 - (1 - env) * _ReflectiveBlend) * diffuse;
    float3 envAdd = env + lerp(diffuse, diffuse * _ReflectCol.rgb, _ReflectiveBlend); 
    float3 envNormal = lerp(envMul, envAdd, _ReflectiveMulOrAdd);
    float3 envOverlayed = env + (1 - _ReflectiveBlend) * diffuse;
    env = lerp(envNormal, envOverlayed, _ReflectiveOverlayed);

    diffuse = lerp(diffuse, env, (metallicMap) * (1 - _UseKKMetal) * matCapAttenuation * reflectMap);
    return max(diffuse, 1E-06);
}

#endif
