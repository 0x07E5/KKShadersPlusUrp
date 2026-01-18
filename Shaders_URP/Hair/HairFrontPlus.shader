// KKShadersPlus URP - HairFrontPlus
// Converted from Built-in RP to URP for Unity 2022.3
// This is the front hair variant with different specular behavior

Shader "xukmi/URP/HairFrontPlus"
{
    Properties
    {
        _AnotherRamp ("Another Ramp(ViewDir)", 2D) = "white" {}
        _MainTex ("MainTex", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _AlphaMask ("Alpha Mask", 2D) = "white" {}
        _DetailMask ("Detail Mask", 2D) = "black" {}
        _HairGloss ("Gloss Mask", 2D) = "black" {}
        _SpeclarHeight ("Speclar Height", Range(0, 1)) = 0.85
        _SpecularHairPower ("Specular Power", Range(0, 1)) = 1
        _rimpower ("Rim Width", Range(0, 1)) = 0.5
        _rimV ("Rim Strength", Range(0, 1)) = 0.75
        _ShadowExtend ("Shadow Extend", Range(0, 1)) = 0.5
        _ColorMask ("Color Mask", 2D) = "black" {}
        [Gamma]_Color ("Color", Vector) = (1,1,1,1)
        [Gamma]_Color2 ("Color2", Vector) = (0.7843137,0.7843137,0.7843137,1)
        [Gamma]_Color3 ("Color3", Vector) = (0.5,0.5,0.5,1)
        [Gamma]_GlossColor ("GlossColor", Vector) = (1.0,1.0,1.0,1.0)
        [Gamma]_SpecularColor ("SpecularColor", Vector) = (1.0,1.0,1.0,1.0)
        [Gamma]_LineColor ("LineColor", Vector) = (0.5,0.5,0.5,1)
        [Gamma]_ShadowColor ("Shadow Color", Vector) = (0.628,0.628,0.628,1)
        _ShadowHSV ("Shadow HSV", Vector) = (0, 0, 0, 0)
        [Gamma]_CustomAmbient("Custom Ambient", Color) = (0.666666666, 0.666666666, 0.666666666, 1)
        _NormalMapScale ("NormalMapScale", Float) = 1
        _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
        [MaterialToggle] _UseRampForLights ("Use Ramp For Light", Float) = 1
        [MaterialToggle] _UseRampForSpecular ("Use Ramp For Specular", Float) = 0
        [MaterialToggle] _SpecularIsHighlights ("Specular is highlight", Float) = 0
        _SpecularIsHighLightsPow ("Specular is highlight", Range(0,128)) = 64
        _SpecularIsHighlightsRange ("Specular is highlight Range", Range(0, 20)) = 5
        [MaterialToggle] _UseMeshSpecular ("Use Mesh Specular", Float) = 0
        [MaterialToggle] _UseLightColorSpecular ("Use Light Color Specular", Float) = 1
        _EmissionMask ("Emission Mask", 2D) = "black" {}
        [Gamma]_EmissionColor("Emission Color", Color) = (1, 1, 1, 1)
        _EmissionIntensity("Emission Intensity", Float) = 1
        _EmissionMaskMode("Emission Mask Mode", Float) = 0
        _EmissionKeepCol("Emission Keep Base Color", Float) = 0
        _LineWidthS ("LineWidthS", Float) = 1
        [Enum(Off,0,On,1)]_OutlineOn ("Outline On", Float) = 1.0
        [Enum(Off,0,On,1)]_SpecularHeightInvert ("Specular Height Invert", Float) = 0
        [MaterialToggle] _UseDetailRAsSpecularMap ("Use DetailR as Specular Map", Float) = 0

        _UseKKPRim ("Use KKP Rim", Range(0 ,1)) = 0
        [Gamma]_KKPRimColor ("Body Rim Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _KKPRimSoft ("Body Rim Softness", Float) = 1.5
        _KKPRimIntensity ("Body Rim Intensity", Float) = 0.75
        _KKPRimAsDiffuse ("Body Rim As Diffuse", Range(0, 1)) = 0.0
        _KKPRimRotateX("Body Rim Rotate X", Float) = 0.0
        _KKPRimRotateY("Body Rim Rotate Y", Float) = 0.0
        
        _DisablePointLights ("Disable Point Lights", Range(0,1)) = 0.0
        [MaterialToggle] _AdjustBackfaceNormals ("Adjust Backface Normals", Float) = 0.0
        [Enum(Off,0,Front,1,Back,2)] _CullOption ("Cull Option", Range(0, 2)) = 0
        _rimReflectMode ("Rimlight Placement", Float) = 0.0
        
        _SpecularNormalScale ("Specular Normal Map Relative Scale", Float) = 1
        _Saturation ("Saturation", Float) = 1
        
        // URP specific
        _RampG ("Ramp Texture", 2D) = "white" {}
        _NormalMask ("Normal Mask", 2D) = "black" {}
        _FaceShadowG ("Face Shadow G", Float) = 0
        _FaceNormalG ("Face Normal G", Float) = 0
        [MaterialToggle] _UseRampForShadows ("Use Ramp For Shadows", Float) = 0
        
        // Global params
        _linewidthG ("Line Width G", Float) = 1
        _ambientshadowG ("Ambient Shadow G", Vector) = (0.5, 0.5, 0.5, 0.5)
    }
    
    SubShader
    {
        Tags 
        { 
            "RenderType" = "Opaque" 
            "RenderPipeline" = "UniversalPipeline"
            "Queue" = "Geometry"
        }
        LOD 600

        // Outline Pass
        Pass
        {
            Name "Outline"
            Tags { "LightMode" = "SRPDefaultUnlit" }
            
            Cull Front
            
            HLSLPROGRAM
            #pragma vertex OutlineVert
            #pragma fragment OutlineFrag
            #pragma target 3.0
            
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "KKPHairInput.hlsl"
            #include "KKPHairDiffuse.hlsl"

            struct OutlineVaryings
            {
                float4 posCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWS : TEXCOORD1;
            };

            OutlineVaryings OutlineVert(VertexData v)
            {
                OutlineVaryings o = (OutlineVaryings)0;
                
                float alphaMask = SAMPLE_TEX2D_LOD(_AlphaMask, v.uv0 * _AlphaMask_ST.xy + _AlphaMask_ST.zw, 0).r;
                float mainAlpha = SAMPLE_TEX2D_LOD(_MainTex, v.uv0 * _MainTex_ST.xy + _MainTex_ST.zw, 0).a;
                float alpha = alphaMask * mainAlpha;
                o.posWS = mul(GetObjectToWorldMatrix(), v.vertex);

                float3 viewDir = o.posWS.xyz - GetCameraPositionWS(); 
                float viewVal = dot(viewDir, viewDir);
                viewVal = sqrt(viewVal);
                viewVal = viewVal * 0.0999999866 + 0.300000012;
                float lineVal = _linewidthG * 0.00499999989;
                viewVal *= lineVal * _LineWidthS;
                alpha *= viewVal;

                float4 detailMask = SAMPLE_TEX2D_LOD(_DetailMask, float4(v.uv0 * _DetailMask_ST.xy + _DetailMask_ST.zw, 0, 0), 0);
                float inverseMask = 1 - detailMask.z;
                alpha *= inverseMask;

                float4 u_xlat0;
                u_xlat0.xyz = v.normal.xyz * alpha + v.vertex.xyz;
                o.posCS = TransformObjectToHClip(u_xlat0.xyz);
                o.uv0 = v.uv0;
                return o;
            }

            half4 OutlineFrag(OutlineVaryings i) : SV_Target
            {
                float4 mainTex = SAMPLE_TEX2D(_MainTex, i.uv0 * _MainTex_ST.xy + _MainTex_ST.zw);
                float alpha = AlphaClip(i.uv0, _OutlineOn ? mainTex.a : 0);

                float3 diffuse = GetDiffuse(i.uv0);
                float3 diffuseMainTex = -diffuse * mainTex.xyz + 1;
                diffuse = mainTex.rgb * diffuse;
                diffuse *= _LineColor.rgb;
                diffuse += diffuse;
                float3 lineColor = _LineColor.rgb - 0.5;
                lineColor = -lineColor * 2 + 1;
                lineColor = -lineColor * diffuseMainTex + 1;
            
                bool3 colCheck = 0.5 < _LineColor.rgb;        
                {
                    float3 hlslcc_movcTemp = diffuse;
                    hlslcc_movcTemp.x = (colCheck.x) ? lineColor.x : diffuse.x;
                    hlslcc_movcTemp.y = (colCheck.y) ? lineColor.y : diffuse.y;
                    hlslcc_movcTemp.z = (colCheck.z) ? lineColor.z : diffuse.z;
                    diffuse = hlslcc_movcTemp;
                }    
                diffuse = saturate(diffuse);
                
                Light mainLight = GetMainLight();
                float3 lightCol = mainLight.color * float3(0.600000024, 0.600000024, 0.600000024) + _CustomAmbient.rgb;
                diffuse = applySaturation(diffuse * lightCol, _Saturation);

                return half4(diffuse, 1);
            }
            ENDHLSL
        }
        
        // Main Forward Pass
        Pass
        {
            Name "Forward"
            Tags { "LightMode" = "UniversalForward" }
            
            Cull [_CullOption]
            
            HLSLPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile _ LIGHTMAP_ON
            
            #define KKP_EXPENSIVE_RAMP
            #define HAIR_FRONT
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "../KKPCommon.hlsl"
            #include "KKPHairInput.hlsl"
            #include "KKPHairDiffuse.hlsl"
            #include "KKPHairNormals.hlsl"
            #include "../KKPVertexLights.hlsl"
            #include "../KKPVertexLightsSpecular.hlsl"
            #include "../KKPEmission.hlsl"
            
            #include "KKPHairVertFrag.hlsl"
            
            ENDHLSL
        }
        
        // Shadow Caster Pass
        Pass
        {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }
            
            ZWrite On
            ZTest LEqual
            ColorMask 0
            Cull Back
            
            HLSLPROGRAM
            #pragma vertex ShadowVert
            #pragma fragment ShadowFrag
            #pragma target 3.0
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "KKPHairInput.hlsl"

            struct ShadowVaryings
            {
                float4 posCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            
            float3 _LightDirection;
            float3 _LightPosition;

            ShadowVaryings ShadowVert(VertexData v)
            {
                ShadowVaryings o = (ShadowVaryings)0;
                o.uv0 = v.uv0;
                
                float3 posWS = TransformObjectToWorld(v.vertex.xyz);
                float3 normalWS = TransformObjectToWorldNormal(v.normal);
                
                #if _CASTING_PUNCTUAL_LIGHT_SHADOW
                    float3 lightDirectionWS = normalize(_LightPosition - posWS);
                #else
                    float3 lightDirectionWS = _LightDirection;
                #endif
                
                o.posCS = TransformWorldToHClip(ApplyShadowBias(posWS, normalWS, lightDirectionWS));
                
                #if UNITY_REVERSED_Z
                    o.posCS.z = min(o.posCS.z, UNITY_NEAR_CLIP_VALUE);
                #else
                    o.posCS.z = max(o.posCS.z, UNITY_NEAR_CLIP_VALUE);
                #endif
                
                return o;
            }

            half4 ShadowFrag(ShadowVaryings i) : SV_Target
            {
                float4 mainTex = SAMPLE_TEX2D(_MainTex, i.uv0 * _MainTex_ST.xy + _MainTex_ST.zw);
                float2 alphaUV = i.uv0 * _AlphaMask_ST.xy + _AlphaMask_ST.zw;
                float4 alphaMask = SAMPLE_TEX2D(_AlphaMask, alphaUV);
                float alphaVal = alphaMask.x * mainTex.a;
                clip(alphaVal - _Cutoff);
                
                return 0;
            }
            ENDHLSL
        }
        
        // Depth Only Pass
        Pass
        {
            Name "DepthOnly"
            Tags { "LightMode" = "DepthOnly" }
            
            ZWrite On
            ColorMask R
            Cull [_CullOption]
            
            HLSLPROGRAM
            #pragma vertex DepthVert
            #pragma fragment DepthFrag
            #pragma target 3.0
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "KKPHairInput.hlsl"

            struct DepthVaryings
            {
                float4 posCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };

            DepthVaryings DepthVert(VertexData v)
            {
                DepthVaryings o = (DepthVaryings)0;
                o.uv0 = v.uv0;
                o.posCS = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }

            half4 DepthFrag(DepthVaryings i) : SV_Target
            {
                float4 mainTex = SAMPLE_TEX2D(_MainTex, i.uv0 * _MainTex_ST.xy + _MainTex_ST.zw);
                float2 alphaUV = i.uv0 * _AlphaMask_ST.xy + _AlphaMask_ST.zw;
                float4 alphaMask = SAMPLE_TEX2D(_AlphaMask, alphaUV);
                float alphaVal = alphaMask.x * mainTex.a;
                clip(alphaVal - _Cutoff);
                
                return 0;
            }
            ENDHLSL
        }
    }
    
    Fallback "Universal Render Pipeline/Lit"
}
