// KKShadersPlus URP - EyeW Plus Fragment
// URP Version - Eye Whites

#ifndef KKP_EYEWPLUSFRAG_URP
#define KKP_EYEWPLUSFRAG_URP

half4 fragEyeW(Varyings i) : SV_Target
{
    // Get main light
    Light mainLight = GetMainLight();
    float3 mainLightColor = mainLight.color;
    float3 worldLightDir = normalize(mainLight.direction);

    float4 mainTex = SAMPLE_TEX2D(_MainTex, i.uv0 * _MainTex_ST.xy + _MainTex_ST.zw);
    float alpha = mainTex.a - _Cutoff;

    // Because of the stencil the shader needs to alpha clip otherwise the whole mesh shows over the hair
    float clipVal = alpha < 0.0f;
    if(clipVal * int(0xffffffffu) != 0)
        discard;
    alpha = mainTex.a;

    float4 ambientShadow = 1 - _ambientshadowG.wxyz;
    float3 ambientShadowIntensity = -ambientShadow.x * ambientShadow.yzw + 1;
    float ambientShadowAdjust = _ambientshadowG.w * 0.5 + 0.5;
    float ambientShadowAdjustDoubled = ambientShadowAdjust + ambientShadowAdjust;
    bool ambientShadowAdjustShow = 0.5 < ambientShadowAdjust;
    ambientShadow.rgb = ambientShadowAdjustDoubled * _ambientshadowG.rgb;
    float3 finalAmbientShadow = ambientShadowAdjustShow ? ambientShadowIntensity : ambientShadow.rgb;
    finalAmbientShadow = saturate(finalAmbientShadow);
    float3 invertFinalAmbientShadow = 1 - finalAmbientShadow;

    finalAmbientShadow *= _shadowcolor.xyz;
    finalAmbientShadow = finalAmbientShadow + finalAmbientShadow;

    float3 shadowColor = _shadowcolor.xyz - 0.5;
    shadowColor = -shadowColor * 2 + 1;
    invertFinalAmbientShadow = -shadowColor * invertFinalAmbientShadow + 1;
    bool3 shadowCheck = 0.5 < _shadowcolor.rgb;
    {
        float3 hlslcc_movcTemp = finalAmbientShadow;
        hlslcc_movcTemp.x = (shadowCheck.x) ? invertFinalAmbientShadow.x : finalAmbientShadow.x;
        hlslcc_movcTemp.y = (shadowCheck.y) ? invertFinalAmbientShadow.y : finalAmbientShadow.y;
        hlslcc_movcTemp.z = (shadowCheck.z) ? invertFinalAmbientShadow.z : finalAmbientShadow.z;
        finalAmbientShadow = hlslcc_movcTemp;
    }
    finalAmbientShadow = saturate(finalAmbientShadow);

    float3 diffuse = mainTex.rgb * _Color.rgb;
    float3 shadedDiffuse = diffuse * finalAmbientShadow;
    float3 finalCol = mainTex.rgb * _Color.rgb - shadedDiffuse;

    KKVertexLight vertexLights[4];
#ifdef _ADDITIONAL_LIGHTS
    GetVertexLightsTwo(vertexLights, i.posWS.xyz, _DisablePointLights);    
#endif
    float4 vertexLighting = 0.0;
    float vertexLightRamp = 1.0;
#ifdef _ADDITIONAL_LIGHTS
    vertexLighting = GetVertexLighting(vertexLights, i.normalWS);
    float2 vertexLightRampUV = vertexLighting.a * _RampG_ST.xy + _RampG_ST.zw;
    vertexLightRamp = SAMPLE_TEX2D(_RampG, vertexLightRampUV).x;
    float3 rampLighting = GetRampLighting(vertexLights, i.normalWS, vertexLightRamp);
    vertexLighting.rgb = _UseRampForLights ? rampLighting : vertexLighting.rgb;
#endif

    float lambert = dot(worldLightDir, i.normalWS.xyz) + vertexLighting.a;
    float ramp = SAMPLE_TEX2D(_RampG, lambert * _RampG_ST.xy + _RampG_ST.zw).x;
    finalCol = ramp * finalCol + shadedDiffuse;
    
    float shadowAttenuation = saturate(ramp);
#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
    float shadowMap = MainLightRealtimeShadow(i.shadowCoord);
    shadowAttenuation *= shadowMap;
#endif

    float3 lightCol = (mainLightColor + vertexLighting.rgb * vertexLightRamp) * float3(0.600000024, 0.600000024, 0.600000024) + _CustomAmbient.rgb;
    lightCol = max(lightCol, _ambientshadowG.xyz);
    finalCol = applySaturation(finalCol * lightCol, _Saturation);
    
    float3 hsl = RGBtoHSL(finalCol);
    hsl.x = hsl.x + _ShadowHSV.x;
    hsl.y = hsl.y + _ShadowHSV.y;
    hsl.z = hsl.z + _ShadowHSV.z;
    finalCol = lerp(HSLtoRGB(hsl), finalCol, saturate(shadowAttenuation + 0.5));

    // Overlay emission over everything
    float4 emission = GetEmission(i.uv0);
    finalCol = CombineEmission(finalCol, emission);
    
    return half4(max(finalCol, 1E-06), alpha);
}

#endif
