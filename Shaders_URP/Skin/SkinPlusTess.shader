// KKShadersPlus URP - SkinPlus
// Converted from Built-in RP to URP for Unity 2022.3

Shader "xukmi/URP/SkinPlusTess"
{
    Properties
    {
        _ColMask ("Color Mask", 2D) = "black" {}
        [Gamma]_Col0 ("Color 0", Color) = (1, 1, 1, 1)
        [Gamma]_Col1 ("Color 1", Color) = (1, 1, 1, 1)
        [Gamma]_Col2 ("Color 2", Color) = (1, 1, 1, 1)
        [Gamma]_Col3 ("Color 3", Color) = (1, 1, 1, 1)
        
        _MainTex ("MainTex", 2D) = "white" {}
        [Gamma]_overcolor1 ("Over Color1", Vector) = (1,1,1,1)
        _overtex1 ("Over Tex1", 2D) = "black" {}
        [Gamma]_overcolor2 ("Over Color2", Vector) = (1,1,1,1)
        _overtex2 ("Over Tex2", 2D) = "black" {}
        [Gamma]_overcolor3 ("Over Color3", Vector) = (1,1,1,1)
        _overtex3 ("Over Tex3", 2D) = "black" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalMapDetail ("Normal Map Detail", 2D) = "bump" {}
        _DetailMask ("Detail Mask", 2D) = "black" {}
        _LineMask ("Line Mask", 2D) = "black" {}
        _AlphaMask ("Alpha Mask", 2D) = "white" {}
        _EmissionMask ("Emission Mask", 2D) = "black" {}
        [Gamma]_EmissionColor("Emission Color", Color) = (1, 1, 1, 1)
        _EmissionIntensity("Emission Intensity", Float) = 1
        _EmissionMaskMode("Emission Mask Mode", Float) = 0
        _EmissionKeepCol("Emission Keep Base Color", Float) = 0
        [Gamma]_ShadowColor ("Shadow Color", Color) = (0.628,0.628,0.628,1)
        _ShadowHSV ("Shadow HSV", Vector) = (0, 0, 0, 0)
        [Gamma]_SpecularColor ("Specular Color", Vector) = (1,1,1,0)
        _DetailNormalMapScale ("DetailNormalMapScale", Range(0, 1)) = 1
        _NormalMapScale ("NormalMapScale", Float) = 1
        _SpeclarHeight ("Speclar Height", Range(0, 1)) = 0.98
        _SpecularPower ("Specular Power", Range(0, 1)) = 0
        _SpecularPowerNail ("Specular Power Nail", Range(0, 1)) = 0
        _ShadowExtend ("Shadow Extend", Range(0, 1)) = 1
        _rimpower ("Rim Width", Range(0, 1)) = 0.5
        _rimV ("Rim Strength", Range(0, 1)) = 0
        _nipsize ("nipsize", Range(0, 1)) = 0.5
        [MaterialToggle] _alpha_a ("alpha_a", Float) = 1
        [MaterialToggle] _alpha_b ("alpha_b", Float) = 1
        [MaterialToggle] _linetexon ("Line Tex On", Float) = 1
        [MaterialToggle] _notusetexspecular ("not use tex specular", Float) = 0
        [MaterialToggle] _nip ("nip?", Float) = 0
        _liquidmask ("Liquid Mask", 2D) = "black" {}
        _Texture2 ("Liquid Tex", 2D) = "black" {}
        _Texture3 ("Liquid Normal", 2D) = "bump" {}
        _LiquidTiling ("Liquid Tiling (u/v/us/vs)", Vector) = (0,0,2,2)
        _liquidftop ("liquidftop", Range(0, 2)) = 0
        _liquidfbot ("liquidfbot", Range(0, 2)) = 0
        _liquidbtop ("liquidbtop", Range(0, 2)) = 0
        _liquidbbot ("liquidbbot", Range(0, 2)) = 0
        _liquidface ("liquidface", Range(0, 2)) = 0
        _nip_specular ("nip_specular", Range(0, 1)) = 0.5
        _tex1mask ("tex1 mask(1=yes)", Float) = 0
        _NormalMask ("NormalMask(G)", 2D) = "black" {}
        _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
        [Gamma]_CustomAmbient("Custom Ambient", Color) = (0.666666666, 0.666666666, 0.666666666, 1)
        [MaterialToggle] _UseRampForLights ("Use Ramp For Light", Float) = 1
        [MaterialToggle] _UseRampForSpecular ("Use Ramp For Specular", Float) = 0
        [MaterialToggle] _UseRampForShadows ("Use Ramp For Shadows", Float) = 0
        [MaterialToggle] _UseLightColorSpecular ("Use Light Color Specular", Float) = 1
        [MaterialToggle] _UseDetailRAsSpecularMap ("Use DetailR as Specular Map", Float) = 0
        _LineWidthS ("LineWidthS", Float) = 1
        [Enum(Off,0,On,1)]_OutlineOn ("Outline On", Float) = 1.0
        [Gamma]_OutlineColor ("Outline Color", Color) = (0, 0, 0, 0)

        _UseKKPRim ("Use KKP Rim", Range(0 ,1)) = 0
        [Gamma]_KKPRimColor ("Body Rim Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _KKPRimSoft ("Body Rim Softness", Float) = 1.5
        _KKPRimIntensity ("Body Rim Intensity", Float) = 0.75
        _KKPRimAsDiffuse ("Body Rim As Diffuse", Range(0, 1)) = 0.0
        _KKPRimRotateX("Body Rim Rotate X", Float) = 0.0
        _KKPRimRotateY("Body Rim Rotate Y", Float) = 0.0
        
        _DisablePointLights ("Disable Point Lights", Float) = 0.0
        [MaterialToggle] _AdjustBackfaceNormals ("Adjust Backface Normals", Float) = 0.0
        _rimReflectMode ("Rimlight Placement", Float) = 0.0
        
        _SpecularNormalScale ("Specular Normal Map Relative Scale", Float) = 1
        _SpecularDetailNormalScale ("Specular Detail Normal Map Relative Scale", Float) = 1
        
        _Saturation ("Saturation", Float) = 1
        
        // URP specific
        _RampG ("Ramp Texture", 2D) = "white" {}
        _FaceShadowG ("Face Shadow G", Float) = 0
        _FaceNormalG ("Face Normal G", Float) = 0
        _TessTex("Tessellation Texture", 2D) = "gray" {}
        _TessMax ("Tessellation Max", Float) = 30
        _TessMin ("Tessellation Min", Float) = 1
        _TessBias ("Tessellation Bias", Float) = 3
        _TessSmooth ("Tessellation Smoothness", Float) = 0.5
        _Tolerance ("Tolerance", Float) = 0.1

        
        // Global params
        _linewidthG ("Line Width G", Float) = 1
        _ambientshadowG ("Ambient Shadow G", Vector) = (0.5, 0.5, 0.5, 0.5)
        _LineColorG ("Line Color G", Vector) = (0.5, 0.5, 0.5, 0.5)
    }
    
    SubShader
    {
        Tags 
        { 
            "RenderType" = "TransparentCutout" 
            "RenderPipeline" = "UniversalPipeline"
            "Queue" = "AlphaTest-100"
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
            #include "../KKPCommon.hlsl"
            #include "KKPSkinInput.hlsl"
            #include "../KKPDisplace.hlsl"
            #include "KKPDiffuse.hlsl"

            struct OutlineVaryings
            {
                float4 posCS : SV_POSITION;
                float4 color : COLOR;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float2 uv3 : TEXCOORD3;
                float4 posWS : TEXCOORD4;
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
                viewVal *= lineVal * _LineWidthS;
                float2 detailMaskUV = v.uv0 * _DetailMask_ST.xy + _DetailMask_ST.zw;
                float4 detailMask = SAMPLE_TEX2D_LOD(_DetailMask, float4(detailMaskUV, 0, 0), 0);
                float detailB = 1 - detailMask.b;
                viewVal *= detailB;
                float3 invertSquare;
                float3 x;
                float3 y;
                float3 z;
                float4x4 worldToObj = GetWorldToObjectMatrix();
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
                o.color = v.color;
                o.uv0 = v.uv0;
                #ifdef TESS_SHADER
                DisplacementValues(v, v.vertex, v.normal);
                #endif
                o.uv1 = v.uv1;
                o.uv2 = v.uv2;
                o.uv3 = v.uv3;
                return o;
            }
            
            // Create a mock Varyings for GetDiffuse
            Varyings CreateMockVaryings(OutlineVaryings i)
            {
                Varyings v = (Varyings)0;
                v.color = i.color;
                v.uv0 = i.uv0;
                v.uv1 = i.uv1;
                v.uv2 = i.uv2;
                v.uv3 = i.uv3;
                v.posWS = i.posWS;
                return v;
            }

            half4 OutlineFrag(OutlineVaryings i, half frontFace : VFACE) : SV_Target
            {
                // Defined in Diffuse
                AlphaClip(i.uv0, _OutlineOn ? 1 : 0);
                
                Varyings mockV = CreateMockVaryings(i);
                float3 diffuse = GetDiffuse(mockV);
                float3 u_xlat1;
                MapValuesOutline(diffuse, u_xlat1);

                bool3 compTest = 0.555555582 < u_xlat1.xyz;
                float3 diffuseShaded = u_xlat1.xyz * 0.899999976 - 0.5;
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

                u_xlat1.xyz *= finalAmbientShadow;
                u_xlat1.xyz *= 1.79999995;
                diffuseShaded = -diffuseShaded * invertFinalAmbientShadow + 1;
                {
                    float3 hlslcc_movcTemp = u_xlat1;
                    hlslcc_movcTemp.x = (compTest.x) ? diffuseShaded.x : u_xlat1.x;
                    hlslcc_movcTemp.y = (compTest.y) ? diffuseShaded.y : u_xlat1.y;
                    hlslcc_movcTemp.z = (compTest.z) ? diffuseShaded.z : u_xlat1.z;
                    u_xlat1 = saturate(hlslcc_movcTemp);
                }
                float3 finalDiffuse = diffuse * u_xlat1.xyz;
                float2 detailMaskUV = i.uv0 * _DetailMask_ST.xy + _DetailMask_ST.zw;
                float4 detailMask = SAMPLE_TEX2D(_DetailMask, detailMaskUV);

                float detailGInv = 1 - detailMask.g;
                detailGInv = detailGInv * 0.5 + 0.5;
                float3 outLineCol = -finalDiffuse * detailGInv + 1;
                finalDiffuse *= detailGInv;
                float outlineBlend = _LineColorG.a - 0.5;
                outlineBlend = -outlineBlend * 2.0 + 1.0;
                outLineCol = -outlineBlend * outLineCol + 1;

                float outlineADoubled = _LineColorG.w * 2;
                finalDiffuse *= outlineADoubled;

                finalDiffuse = 0.5 < _LineColorG.w ? outLineCol : finalDiffuse;
                finalDiffuse = saturate(finalDiffuse);
                
                Light mainLight = GetMainLight();
                outLineCol = mainLight.color * float3(0.600000024, 0.600000024, 0.600000024) + _CustomAmbient.rgb;

                float3 finalColor = finalDiffuse * outLineCol;
                finalColor = applySaturation(lerp(finalColor, _OutlineColor.rgb, _OutlineColor.a), _Saturation);
                return half4(max(finalColor, 1E-06), 1.0);
            }
            
            #include "KKPTess.hlsl"
            ENDHLSL
        }

        // Main Forward Pass
        Pass
        {
            Name "Forward"
            Tags { "LightMode" = "UniversalForward" }
            
            Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            
            HLSLPROGRAM
            #pragma target 4.6
            #pragma vertex TessVert
            #pragma hull hull
            #pragma domain domain
            #define TESS_SHADER

            #pragma fragment frag
            
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile _ LIGHTMAP_ON
            
            #define KKP_EXPENSIVE_RAMP
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "../KKPCommon.hlsl"
            #include "KKPSkinInput.hlsl"
            #include "../KKPDisplace.hlsl"
            #include "KKPDiffuse.hlsl"
            #include "KKPNormals.hlsl"
            #include "../KKPVertexLights.hlsl"
            #include "../KKPVertexLightsSpecular.hlsl"
            #include "../KKPLighting.hlsl"
            #include "../KKPEmission.hlsl"
            #include "../KKPCoom.hlsl"
            
            #include "KKPSkinFrag.hlsl"
            #include "KKPTess.hlsl"

            Varyings vert(VertexData v)
            {
                Varyings o = (Varyings)0;
                o.posWS = mul(GetObjectToWorldMatrix(), v.vertex);
                o.posCS = TransformWorldToHClip(o.posWS.xyz);
                o.normalWS = TransformObjectToWorldNormal(v.normal);
                o.tanWS = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);
                float3 biTan = cross(o.tanWS.xyz, o.normalWS);
                o.bitanWS = normalize(biTan);
                o.color = v.color;
                o.uv0 = v.uv0;
                #ifdef TESS_SHADER
                DisplacementValues(v, v.vertex, v.normal);
                #endif
                o.uv1 = v.uv1;
                o.uv2 = v.uv2;
                o.uv3 = v.uv3;
                
            #if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                o.shadowCoord = TransformWorldToShadowCoord(o.posWS.xyz);
            #endif
                return o;
            }
            
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
            Cull Off
            
            HLSLPROGRAM
            #pragma target 4.6
            #pragma vertex TessVert
            #pragma hull hull
            #pragma domain domain
            #define TESS_SHADER
            #define SHADOW_CASTER_PASS

            #pragma fragment ShadowFrag
            #pragma target 3.0
            
            #pragma multi_compile_shadowcaster
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "KKPSkinInput.hlsl"
            #include "../KKPDisplace.hlsl"

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
                #ifdef TESS_SHADER
                DisplacementValues(v, v.vertex, v.normal);
                #endif
                
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
                float2 alphaUV = i.uv0 * _AlphaMask_ST.xy + _AlphaMask_ST.zw;
                float4 alphaMask = SAMPLE_TEX2D(_AlphaMask, alphaUV);
                float2 alphaVal = -float2(_alpha_a, _alpha_b) + float2(1.0f, 1.0f);
                alphaVal = max(alphaVal, alphaMask.xy);
                alphaVal = min(alphaVal.y, alphaVal.x);
                clip(alphaVal.x - 0.5);
                
                return 0;
            }
            
            #include "KKPTess.hlsl"
            ENDHLSL
        }
        
        // Depth Only Pass
        Pass
        {
            Name "DepthOnly"
            Tags { "LightMode" = "DepthOnly" }
            
            ZWrite On
            ColorMask R
            Cull Off
            
            HLSLPROGRAM
            #pragma target 4.6
            #pragma vertex TessVert
            #pragma hull hull
            #pragma domain domain
            #define TESS_SHADER
            #define DEPTH_ONLY_PASS

            #pragma fragment DepthFrag
            #pragma target 3.0
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            #include "../KKPDeclarations.hlsl"
            #include "KKPSkinInput.hlsl"
            #include "../KKPDisplace.hlsl"

            struct DepthVaryings
            {
                float4 posCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };

            DepthVaryings DepthVert(VertexData v)
            {
                DepthVaryings o = (DepthVaryings)0;
                o.uv0 = v.uv0;
                #ifdef TESS_SHADER
                DisplacementValues(v, v.vertex, v.normal);
                #endif
                o.posCS = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }

            half4 DepthFrag(DepthVaryings i) : SV_Target
            {
                float2 alphaUV = i.uv0 * _AlphaMask_ST.xy + _AlphaMask_ST.zw;
                float4 alphaMask = SAMPLE_TEX2D(_AlphaMask, alphaUV);
                float2 alphaVal = -float2(_alpha_a, _alpha_b) + float2(1.0f, 1.0f);
                alphaVal = max(alphaVal, alphaMask.xy);
                alphaVal = min(alphaVal.y, alphaVal.x);
                clip(alphaVal.x - 0.5);
                
                return 0;
            }
            
            #include "KKPTess.hlsl"
            ENDHLSL
        }
    }
    
    Fallback "Universal Render Pipeline/Lit"
}
