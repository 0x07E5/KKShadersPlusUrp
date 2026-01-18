// KKShadersPlus URP - Hair Normals
// URP Version

#ifndef KKP_HAIRNORMAL_URP
#define KKP_HAIRNORMAL_URP

float3 GetNormal(Varyings i) {    
    // Normals
    float2 normalUV = i.uv0 * _NormalMap_ST.xy + _NormalMap_ST.zw;
    return UnpackScaleNormal(SAMPLE_TEX2D(_NormalMap, normalUV), _NormalMapScale);
}

float3 CreateBinormal(float3 normal, float3 tangent, float binormalSign) {
    return cross(normal, tangent.xyz) * binormalSign;
}

float3 NormalAdjust(Varyings i, float3 finalCombinedNormal, int faceDir) {
    float3 normal = finalCombinedNormal;

    float3 binormal = CreateBinormal(i.normalWS, i.tanWS.xyz, i.tanWS.w);
    normal = normalize(
        finalCombinedNormal.x * i.tanWS.xyz +
        finalCombinedNormal.y * binormal +
        finalCombinedNormal.z * i.normalWS
    );

    // This gives some items correct shading on backfaces but messes up mirror shading
    int adjust = int(floor(_AdjustBackfaceNormals));
    return adjust ? normal * (faceDir <= 0 ? -1 : 1) : normal;
}

#endif
