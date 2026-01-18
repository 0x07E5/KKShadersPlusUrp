// KKShadersPlus URP - Item Normals
// URP Version

#ifndef KKP_ITEMNORMAL_URP
#define KKP_ITEMNORMAL_URP

float3 GetNormal(Varyings i) {    
    // Normals
    float2 detailNormalUV = i.uv0 * _NormalMapDetail_ST.xy + _NormalMapDetail_ST.zw;
    float4 packedNormalDetail = SAMPLE_TEX2D_SAMPLER(_NormalMapDetail, _NormalMap, detailNormalUV);
    float3 detailNormal = UnpackScaleNormal(packedNormalDetail, _DetailNormalMapScale);
    float2 normalUV = i.uv0 * _NormalMap_ST.xy + _NormalMap_ST.zw;
    float4 packedNormal = SAMPLE_TEX2D(_NormalMap, normalUV);
    float3 normalMap = UnpackScaleNormal(packedNormal, _NormalMapScale);
    float3 mergedNormals = BlendNormals(normalMap, detailNormal);
    return mergedNormals;
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
