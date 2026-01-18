// KKShadersPlus URP - MainOpaquePlus
// Opaque variant of MainItemPlus

Shader "xukmi/URP/MainOpaquePlus"
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
        [Enum(Off,0,Front,1,Back,2)] _CullOption ("Cull Option", Range(0, 2)) = 0
        [Enum(Off,0,On,1)]_AlphaOptionCutoff ("Cutoff On", Float) = 0
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
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "../KKPCommon.hlsl"
            #include "KKPItemInput.hlsl"
            #include "KKPItemDiffuse.hlsl"

            struct OutlineVaryings
            {
                float4 posCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWS : TEXCOORD1;
            };

            OutlineVaryings OutlineVert(VertexData v)
            {
                OutlineVaryings o = (OutlineVaryings)0;
                
                o.posWS = mul(GetObjectToWorldMatrix(), v.vertex);
                float3 viewDir = GetCameraPositionWS() - o.posWS.xyz;
                float viewVal = dot(viewDir, viewDir);
                viewVal = sqrt(viewVal);
                viewVal = viewVal * 0.0999999866 + 0.300000012;
                float lineVal = _linewidthG * 0.00499999989;
                viewVal *= lineVal;
                float2 detailMaskUV = v.uv0 * _DetailMask_ST.xy + _DetailMask_ST.zw;
                float4 detailMask = SAMPLE_TEX2D_LOD(_DetailMask, float4(detailMaskUV, 0, 0), 0);
                float detailB = 1 - detailMask.b;
                viewVal *= detailB * _LineWidthS;
                
                float4x4 worldToObj = GetWorldToObjectMatrix();
                float3 x, y, z;
                x.x = worldToObj[0].x;
                x.y = worldToObj[1].x;
                x.z = worldToObj[2].x;
                float xLen = rsqrt(dot(x, x));
                y.x = worldToObj[0].y;
                y.y = worldToObj[1].y;
                y.z = worldToObj[2].y;
                float yLen = rsqrt(dot(y, y));
                z.x = worldToObj[0].z;
                z.y = worldToObj[1].z;
                z.z = worldToObj[2].z;
                float zLen = rsqrt(dot(z, z));
                float3 view = viewVal / float3(xLen, yLen, zLen);
                view = v.normal * view + v.vertex.xyz;
                o.posCS = TransformObjectToHClip(view);
                
                if(!_OutlineOn)
                    o.posCS = float4(2, 2, 2, 1);
                o.uv0 = v.uv0;
                return o;
            }

            half4 OutlineFrag(OutlineVaryings i) : SV_Target
            {
                float4 mainTex = SAMPLE_TEX2D(_MainTex, i.uv0 * _MainTex_ST.xy + _MainTex_ST.zw);

                float4 colorMask = SAMPLE_TEX2D(_ColorMask, i.uv0 * _ColorMask_ST.xy + _ColorMask_ST.zw);
                float3 color;
                color = colorMask.r * (_Color.rgb - 1) + 1;
                color = colorMask.g * (_Color2.rgb - color) + color;
                color = colorMask.b * (_Color3.rgb - color) + color;
                float3 diffuse = mainTex.rgb * color;

                float3 shadingAdjustment = ShadeAdjustItem(diffuse);

                float3 diffuseShaded = shadingAdjustment * 0.899999976 - 0.5;
                diffuseShaded = -diffuseShaded * 2 + 1;
                float4 ambientShadow = 1 - _ambientshadowG.wxyz;
                float3 ambientShadowIntensity = -ambientShadow.x * ambientShadow.yzw + 1;
                float ambientShadowAdjust = _ambientshadowG.w * 0.5 + 0.5;
                float ambientShadowAdjustDoubled = ambientShadowAdjust + ambientShadowAdjust;
                bool ambientShadowAdjustShow = 0.5 < ambientShadowAdjust;
                ambientShadow.rgb = ambientShadowAdjustDoubled * _ambientshadowG.rgb;
                float3 finalAmbientShadow = ambientShadowAdjustShow ? ambientShadowIntensity : ambientShadow.rgb;
                finalAmbientShadow = saturate(finalAmbientShadow);
                float3 invertFinalAmbientShadow = 1 - finalAmbientShadow;

                bool3 compTest = 0.555555582 < shadingAdjustment;
                shadingAdjustment *= finalAmbientShadow;
                shadingAdjustment *= 1.79999995;
                diffuseShaded = -diffuseShaded * invertFinalAmbientShadow + 1;
                {
                    float3 hlslcc_movcTemp = shadingAdjustment;
                    hlslcc_movcTemp.x = (compTest.x) ? diffuseShaded.x : shadingAdjustment.x;
                    hlslcc_movcTemp.y = (compTest.y) ? diffuseShaded.y : shadingAdjustment.y;
                    hlslcc_movcTemp.z = (compTest.z) ? diffuseShaded.z : shadingAdjustment.z;
                    shadingAdjustment = saturate(hlslcc_movcTemp);
                }
                
                float shadowExtendAnother = saturate(1 - _ShadowExtendAnother + 1) * 0.670000017 + 0.330000013;
                float3 shadowExtendShaded = shadowExtendAnother * shadingAdjustment;

                diffuse = diffuse * _LineColorG.rgb;
                float3 lineCol = -diffuse * shadowExtendShaded + 1;
                diffuse *= shadowExtendShaded;

                float lineAlpha = _LineColorG.w - 0.5;
                lineAlpha = -lineAlpha * 2.0 + 1.0;
                lineCol = -lineAlpha * lineCol + 1;
                lineAlpha = _LineColorG.w * 2;
                diffuse *= lineAlpha;
                diffuse = 0.5 < _LineColorG.w ? lineCol : diffuse;

                float3 finalDiffuse = applySaturation(lerp(diffuse, _OutlineColor.rgb, _OutlineColor.a), _Saturation);
                return half4(finalDiffuse, 1);
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
            
            #define KKP_EXPENSIVE_RAMP
            
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
        
        // Shadow Caster Pass
        Pass
        {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }
            
            ZWrite On
            ZTest LEqual
            ColorMask 0
            Cull [_CullOption]
            
            HLSLPROGRAM
            #pragma vertex ShadowVert
            #pragma fragment ShadowFrag
            #pragma target 3.0
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "KKPItemInput.hlsl"

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
            #include "KKPItemInput.hlsl"

            struct DepthVaryings
            {
                float4 posCS : SV_POSITION;
            };

            DepthVaryings DepthVert(VertexData v)
            {
                DepthVaryings o = (DepthVaryings)0;
                o.posCS = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }

            half4 DepthFrag(DepthVaryings i) : SV_Target
            {
                return 0;
            }
            ENDHLSL
        }
    }
    
    Fallback "Universal Render Pipeline/Lit"
}
