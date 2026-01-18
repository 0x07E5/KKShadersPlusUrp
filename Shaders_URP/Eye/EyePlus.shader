// KKShadersPlus URP - EyePlus
// Converted from Built-in RP to URP for Unity 2022.3

Shader "xukmi/URP/EyePlus"
{
    Properties
    {
        _MainTex ("MainTex", 2D) = "white" {}
        [Gamma]_overcolor1 ("overcolor1", Vector) = (1,1,1,1)
        _overtex1 ("overtex1", 2D) = "black" {}
        [Gamma]_overcolor2 ("overcolor2", Vector) = (1,1,1,1)
        _overtex2 ("overtex2", 2D) = "black" {}
        [MaterialToggle] _isHighLight ("isHighLight", Float) = 0
        _expression ("expression", 2D) = "black" {}
        _exppower ("exppower", Range(0, 1)) = 1
        _ExpressionSize ("Expression Size", Range(0, 1)) = 0.35
        _ExpressionDepth ("Expression Depth", Range(0, 2)) = 1
        [Gamma]_shadowcolor ("shadowcolor", Vector) = (0.6298235,0.6403289,0.747,1)
        _rotation ("rotation", Range(0, 1)) = 0
        [HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
        _EmissionMask ("Emission Mask", 2D) = "black" {}
        [Gamma]_EmissionColor("Emission Color", Color) = (1, 1, 1, 1)
        _EmissionIntensity("Emission Intensity", Float) = 1
        _EmissionMaskMode("Emission Mask Mode", Float) = 0
        _EmissionKeepCol("Emission Keep Base Color", Float) = 1
        [Gamma]_CustomAmbient("Custom Ambient", Color) = (0.666666666, 0.666666666, 0.666666666, 1)
        [MaterialToggle] _UseRampForLights ("Use Ramp For Light", Float) = 1
        _DisablePointLights ("Disable Point Lights", Range(0,1)) = 0.0
        _ShadowHSV ("Shadow HSV", Vector) = (0, 0, 0, 0)

        _ReflectMap ("Reflect Body Map", 2D) = "white" {}
        _Roughness ("Roughness", Range(0, 1)) = 0.75
        _ReflectionVal ("ReflectionVal", Range(0, 1)) = 1.0
        [Gamma]_ReflectCol("Reflection Color", Color) = (1, 1, 1, 1)
        _ReflectionMapCap ("Matcap", 2D) = "white" {}
        _UseMatCapReflection ("Use Matcap or Env", Range(0, 1)) = 1.0
        _ReflBlendSrc ("Reflect Blend Src", Float) = 2.0
        _ReflBlendDst ("Reflect Blend Dst", Float) = 0.0
        _ReflBlendVal ("Reflect Blend Val", Range(0, 1)) = 1.0
        _ReflectColMix ("Reflection Color Mix Amount", Range(0,1)) = 1
        _ReflectRotation ("Matcap Rotation", Range(0, 360)) = 0
        _ReflectMask ("Reflect Body Mask", 2D) = "white" {}
        _DisableShadowedMatcap ("Disable Shadowed Matcap", Range(0,1)) = 0.0
        _Saturation ("Saturation", Float) = 1
        
        // URP specific
        _RampG ("Ramp Texture", 2D) = "white" {}
        _ambientshadowG ("Ambient Shadow G", Vector) = (0.5, 0.5, 0.5, 0.5)
    }
    
    SubShader
    {
        Tags 
        { 
            "RenderType" = "Transparent" 
            "RenderPipeline" = "UniversalPipeline"
            "Queue" = "Transparent"
            "IgnoreProjector" = "true"
        }
        LOD 600

        // Main Forward Pass
        Pass
        {
            Name "Forward"
            Tags { "LightMode" = "UniversalForward" }
            
            Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            Stencil {
                Ref 2
                Comp Always
                Pass Replace
                Fail Keep
                ZFail Keep
            }
            
            HLSLPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            
            #define KKP_EXPENSIVE_RAMP
            #define MOVE_PUPILS
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "../KKPCommon.hlsl"
            #include "KKPEyeInput.hlsl"
            #include "KKPEyeDiffuse.hlsl"
            #include "../KKPVertexLights.hlsl"
            #include "../KKPEmission.hlsl"

            Varyings vert(VertexData v)
            {
                Varyings o = (Varyings)0;
                o.posWS = mul(GetObjectToWorldMatrix(), v.vertex);
                o.posCS = TransformWorldToHClip(o.posWS.xyz);
                o.normalWS = TransformObjectToWorldNormal(v.normal);
                o.tanWS = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);
                float3 biTan = cross(o.tanWS.xyz, o.normalWS);
                o.bitanWS = normalize(biTan);
                o.uv0 = v.uv0;
                o.uv1 = v.uv1;
                o.uv2 = v.uv2;
                
            #if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                o.shadowCoord = TransformWorldToShadowCoord(o.posWS.xyz);
            #endif
                return o;
            }

            #include "KKPEyePlusFrag.hlsl"
            
            ENDHLSL
        }
    }
    
    Fallback "Universal Render Pipeline/Lit"
}
