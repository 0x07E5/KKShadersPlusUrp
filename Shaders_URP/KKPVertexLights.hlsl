// KKShadersPlus URP - Vertex Lights
// Adapted for URP's additional lights system

#ifndef KKP_VERTEX_LIGHTING_URP
#define KKP_VERTEX_LIGHTING_URP

// Vertex Lights structure - URP version uses additional lights
struct KKVertexLight {
    float3 pos;
    float3 dir;
    float4 col;
    float atten;
    float lightVal;
    float lightValNoAtten;
};

void GetVertexLights(out KKVertexLight lights[4], float3 surfaceWorldPos) {
    uint additionalLightCount = GetAdditionalLightsCount();
    
    [unroll]
    for(int i = 0; i < 4; i++) {
        KKVertexLight kLight;
        kLight.pos = float3(0, 0, 0);
        kLight.dir = float3(0, 1, 0);
        kLight.col = float4(0, 0, 0, 0);
        kLight.atten = 0;
        kLight.lightVal = 0;
        kLight.lightValNoAtten = 0;
        
        if (i < (int)additionalLightCount) {
            Light additionalLight = GetAdditionalLight(i, surfaceWorldPos);
            kLight.pos = surfaceWorldPos + additionalLight.direction; // Approximate position
            kLight.dir = additionalLight.direction;
            kLight.col = float4(additionalLight.color, 1.0);
            kLight.atten = additionalLight.distanceAttenuation * additionalLight.shadowAttenuation;
        }
        
        lights[i] = kLight;
    }
}

void GetVertexLightsTwo(out KKVertexLight lights[4], float3 surfaceWorldPos, float disablePointLights) {
    uint additionalLightCount = GetAdditionalLightsCount();
    
    [unroll]
    for(int i = 0; i < 4; i++) {
        KKVertexLight kLight;
        kLight.pos = float3(0, 0, 0);
        kLight.dir = float3(0, 1, 0);
        kLight.col = float4(0, 0, 0, 0);
        kLight.atten = 0;
        kLight.lightVal = 0;
        kLight.lightValNoAtten = 0;
        
        if (i < (int)additionalLightCount) {
            Light additionalLight = GetAdditionalLight(i, surfaceWorldPos);
            kLight.pos = surfaceWorldPos + additionalLight.direction;
            kLight.dir = additionalLight.direction;
            kLight.col = float4(additionalLight.color, 1.0);
            kLight.atten = (1.0 - disablePointLights) * additionalLight.distanceAttenuation * additionalLight.shadowAttenuation;
        }
        
        lights[i] = kLight;
    }
}

float LumaGrayscale(float3 col) {
    return col.r * 0.2126 + col.g * 0.7152 + col.b * 0.0722;
}

float MaxGrayscale(float3 col) {
    return max(col.r, max(col.g, col.b));
}

float4 GetVertexLighting(inout KKVertexLight lights[4], float3 normal) {
    float4 finalOutput = 0;
    [unroll]
    for(int i = 0; i < 4; i++) {
        KKVertexLight light = lights[i];
        float dotProduct = dot(normal, light.dir);
        float lighting = dotProduct * light.atten;
        lights[i].lightVal = saturate(lighting);
        lights[i].lightValNoAtten = saturate(dotProduct);
        float3 lightCol = lighting * light.col.rgb;
        finalOutput.rgb += lightCol;
        finalOutput.a += saturate(MaxGrayscale(lightCol));
    }
    finalOutput.rgb = clamp(finalOutput.rgb, 0.0, 1.0);
    return finalOutput;
}

float3 GetRampLighting(inout KKVertexLight lights[4], float3 normal, float ramp) {
    float3 finalOutput = 0;
    [unroll]
    for(int i = 0; i < 4; i++) {
        KKVertexLight light = lights[i];
    #ifdef KKP_EXPENSIVE_RAMP
        float lighting = light.lightValNoAtten;
        float2 lightRampUV = lighting * _RampG_ST.xy + _RampG_ST.zw;
        float lightRamp = SAMPLE_TEX2D(_RampG, lightRampUV).x;
        float atten = smoothstep(0.04, 0.041, light.atten);
        lighting = saturate(lightRamp * atten);
    #else
        float lighting = light.lightValNoAtten;
        lighting = ramp * lighting;
    #endif
        float3 lightCol = lighting * light.col.rgb;
        finalOutput.rgb += lightCol;
    }
    finalOutput.rgb = max(0.0, finalOutput.rgb);
    return finalOutput;
}

#endif
