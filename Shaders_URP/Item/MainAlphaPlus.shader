// KKShadersPlus URP - MainAlphaPlus
// Transparent variant of MainItemPlus with alpha blending

Shader "xukmi/URP/MainAlphaPlus"
{
    Properties
    {
        _AnotherRamp ("Another Ramp(LineR)", 2D) = "white" {}
        _MainTex ("MainTex", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalMapDetail ("Normal Map Detail", 2D) = "bump" {}
        _DetailMask ("Detail Mask", 2D) = "black" {}
        _LineMask ("Line Mask", 2D) = "black" {}
        _EmissionMask ("Emission Mask", 2D) = "black" {}
        [Gamma]_EmissionColor("Emission Color", Color) = (1, 1, 1, 1)
        _EmissionIntensity("Emission Intensity", Float) = 1
        _EmissionMaskMode("Emission Mask Mode", Float) = 0
        _EmissionKeepCol("Emission Keep Base Color", Float) = 0
        [Gamma]_ShadowColor ("Shadow Color", Vector) = (0.628,0.628,0.628,1)
        _ShadowHSV ("Shadow HSV", Vector) = (0, 0, 0, 0)
        [Gamma]_SpecularColor ("Specular Color", Color) = (1,1,1,1)
        _SpecularPower ("Specular Power", Range(0, 1)) = 0
        _SpeclarHeight ("Speclar Height", Range(0, 1)) = 0.98
        _rimpower ("Rim Width", Range(0, 1)) = 0.5
        _rimV ("Rim Strength", Range(0, 1)) = 0.5
        _ShadowExtend ("Shadow Extend", Range(0, 1)) = 1
        _ShadowExtendAnother ("Shadow Extend Another", Range(0, 1)) = 1
        [MaterialToggle] _AnotherRampFull ("Another Ramp Full", Float) = 0
        [MaterialToggle] _DetailBLineG ("DetailB LineG", Float) = 0
        [MaterialToggle] _DetailRLineR ("DetailR LineR", Float) = 0
        [MaterialToggle] _notusetexspecular ("not use tex specular", Float) = 0
        _LineWidthS ("LineWidthS", Float) = 1
        _Clock ("Clock(xy/piv)(z/ang)(w/spd)", Vector) = (0,0,0,0)
        _ColorMask ("Color Mask", 2D) = "black" {}
        [Gamma]_Color ("Color", Color) = (1,0,0,1)
        [Gamma]_Color2 ("Color2", Color) = (0.1172419,0,1,1)
        [Gamma]_Color3 ("Color3", Color) = (0.5,0.5,0.5,1)
        [Gamma]_CustomAmbient("Custom Ambient", Color) = (0.666666666, 0.666666666, 0.666666666, 1)
        _NormalMapScale ("NormalMapScale", Float) = 1
        _DetailNormalMapScale ("Detail Normal Scale", Float) = 1
        [MaterialToggle] _UseRampForLights ("Use Ramp For Light", Float) = 1
        [MaterialToggle] _UseRampForSpecular ("Use Ramp For Specular", Float) = 0
        [MaterialToggle] _UseLightColorSpecular ("Use Light Color Specular", Float) = 1
        [MaterialToggle] _UseDetailRAsSpecularMap ("Use DetailR as Specular Map", Float) = 0
        _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
        _Alpha ("Alpha", Range(0, 1)) = 1
        [Enum(Off,0,Front,1,Back,2)] _CullOption ("Cull Option", Range(0, 2)) = 0
        [Enum(Off,0,On,1,Cutoff,2)]_AlphaOptionCutoff ("Cutoff On", Float) = 0
        [Enum(Off,0,On,1)]_OutlineOn ("Outline On", Float) = 1.0
        [Gamma]_OutlineColor ("Outline Color", Color) = (0, 0, 0, 0)
        _Reflective("Reflective", Range(0, 1)) = 0.75
        [Gamma]_ReflectCol("Reflection Color", Color) = (1, 1, 1, 1)
        _ReflectiveBlend("Reflective Blend", Range(0, 1)) = 0.05
        _ReflectiveMulOrAdd("Mul Or Add", Range(0, 1)) = 1
        _UseKKMetal("Use KK Metal", Range(0, 1)) = 1
        _UseMatCapReflection("Use Mat Cap", Range(0, 1)) = 1
        _ReflectionMapCap("Mat Cap", 2D) = "black" {}
        _UseKKPRim ("Use KKP Rim", Range(0 ,1)) = 0
        [Gamma]_KKPRimColor ("Body Rim Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _KKPRimSoft ("Body Rim Softness", Float) = 1.5
        _KKPRimIntensity ("Body Rim Intensity", Float) = 0.75
        _KKPRimAsDiffuse ("Body Rim As Diffuse", Range(0, 1)) = 0.0
        _KKPRimRotateX("Body Rim Rotate X", Float) = 0.0
        _KKPRimRotateY("Body Rim Rotate Y", Float) = 0.0
        
        _ReflectColMix ("Reflection Color Mix Amount", Range(0,1)) = 1
        _ReflectRotation ("Matcap Rotation", Range(0, 360)) = 0
        _ReflectMapDetail ("Reflect Body Mask/Map", 2D) = "white" {}
        _DisablePointLights ("Disable Point Lights", Range(0,1)) = 0.0
        _DisableShadowedMatcap ("Disable Shadowed Matcap", Range(0,1)) = 0.0
        [MaterialToggle] _AdjustBackfaceNormals ("Adjust Backface Normals", Float) = 0.0
        [Enum(Off,0,On,1)]_ReflectiveOverlayed ("Reflections Overlayed", Float) = 0.0
        _rimReflectMode ("Rimlight Placement", Float) = 0.0
        
        _SpecularNormalScale ("Specular Normal Map Relative Scale", Float) = 1
        _SpecularDetailNormalScale ("Specular Detail Normal Map Relative Scale", Float) = 1
        _Saturation ("Saturation", Float) = 1
        
        // URP / Hidden
        _AlphaMask ("Alpha Mask", 2D) = "white" {}
        _alpha_a ("Alpha A", Float) = 1
        _alpha_b ("Alpha B", Float) = 1
        _RampG ("Ramp Texture", 2D) = "white" {}
        _NormalMask ("Normal Mask", 2D) = "black" {}
        _linewidthG ("Line Width G", Float) = 1
        _ambientshadowG ("Ambient Shadow G", Vector) = (0.5, 0.5, 0.5, 0.5)
        _LineColorG ("Line Color G", Vector) = (0.5, 0.5, 0.5, 0.5)
        _FaceShadowG ("Face Shadow G", Float) = 0
        _FaceNormalG ("Face Normal G", Float) = 0
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
            
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            Cull [_CullOption]
            
            HLSLPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            
            #define KKP_EXPENSIVE_RAMP
            #define ALPHA_SHADER
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "../KKPCommon.hlsl"
            #include "KKPItemInput.hlsl"
            #include "KKPItemDiffuse.hlsl"
            #include "KKPItemNormals.hlsl"
            #include "../KKPVertexLights.hlsl"
            #include "../KKPVertexLightsSpecular.hlsl"
            #include "../KKPEmission.hlsl"
            #include "../KKPReflect.hlsl"

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
                
            #if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                o.shadowCoord = TransformWorldToShadowCoord(o.posWS.xyz);
            #endif
                return o;
            }

            #include "KKPItemFrag.hlsl"
            
            ENDHLSL
        }
    }
    
    Fallback "Universal Render Pipeline/Lit"
}
