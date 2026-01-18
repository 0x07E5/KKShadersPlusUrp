// KKShadersPlus URP - Item Input
// URP Version

#ifndef KKP_ITEM_INPUT_URP
#define KKP_ITEM_INPUT_URP

#include "../KKPDeclarations.hlsl"

struct VertexData
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
    float4 tangent : TANGENT;
    float2 uv0 : TEXCOORD0;
};

struct Varyings
{
    float4 posCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float4 posWS : TEXCOORD1;
    float3 normalWS : TEXCOORD2;
    float4 tanWS : TEXCOORD3;
    float3 bitanWS : TEXCOORD4;
#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
    float4 shadowCoord : TEXCOORD5;
#endif
};

float4 _CustomAmbient;
bool _UseRampForLights;
bool _UseRampForSpecular;
bool _UseRampForShadows;
bool _UseLightColorSpecular;
int _AlphaOptionCutoff;
bool _OutlineOn;
bool _UseDetailRAsSpecularMap;
bool _UseKKPRim;
int _CullOption;
float _UseKKMetal;

float _NormalMapScale;
float _DetailNormalMapScale;

float4 _OutlineColor;

float4 _KKPRimColor;
float _KKPRimSoft;
float _KKPRimIntensity;
float _KKPRimAsDiffuse;
float _KKPRimRotateX;
float _KKPRimRotateY;

// Input Textures
DECLARE_TEX2D(_MainTex);
DECLARE_TEX2D(_AlphaMask);
DECLARE_TEX2D(_NormalMap);
DECLARE_TEX2D_NOSAMPLER(_NormalMapDetail);
DECLARE_TEX2D_NOSAMPLER(_liquidmask);
DECLARE_TEX2D(_Texture2); // Liquid Tex
DECLARE_TEX2D_NOSAMPLER(_Texture3); // Liquid Normal
DECLARE_TEX2D(_ColorMask);
DECLARE_TEX2D_NOSAMPLER(_LineMask);
DECLARE_TEX2D(_DetailMask);
DECLARE_TEX2D(_NormalMask);
DECLARE_TEX2D(_AnotherRamp);
DECLARE_TEX2D(_RampG);

// UV Offsets
float4 _MainTex_ST;
float4 _AlphaMask_ST;
float4 _NormalMap_ST;
float4 _NormalMapDetail_ST;

float4 _liquidmask_ST;
float4 _Texture2_ST; // Liquid Tex
float4 _Texture3_ST; // Liquid Normal
float4 _DetailMask_ST;
float4 _NormalMask_ST;
float4 _AnotherRamp_ST;

float4 _RampG_ST;
float4 _LineMask_ST;

float4 _ColorMask_ST;

// Extra color
DECLARE_TEX2D_NOSAMPLER(_ColMask);
float4 _ColMask_ST;
float4 _Col0;
float4 _Col1;
float4 _Col2;
float4 _Col3;

float _Cutoff;
float4 _ShadowColor;
float _rimpower;
float _rimV;
float4 _SpecularColor;
float4 _ShadowHSV;
float _SpecularNormalScale;
float _SpecularDetailNormalScale;
float _SpeclarHeight;
float _SpecularPower;
float _SpecularPowerNail;
float _ShadowExtend;
float _ShadowExtendAnother;
float _alpha_a;
float _alpha_b;
float _notusetexspecular;
float _liquidftop;
float _liquidfbot;
float _liquidface;
float _liquidbtop;
float _liquidbbot;
float4 _LiquidTiling;
float _DetailRLineR;
float _DetailBLineG;

float4 _TimeEditor;

float _DisablePointLights;
float _AdjustBackfaceNormals;
float _rimReflectMode;
float _DisableShadowedMatcap;

#ifndef DEFINED_CLOCK
#define DEFINED_CLOCK
float4 _Clock;
#endif

float4 _Color;
float4 _Color2;
float4 _Color3;
float _AnotherRampFull;
float _LineWidthS;
float _Alpha;

// Global light params set by KK 
float4 _LineColorG;
float _linewidthG; 
float4 _ambientshadowG;
float _FaceShadowG;
float _FaceNormalG;

#endif
