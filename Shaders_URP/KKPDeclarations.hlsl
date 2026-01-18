// KKShadersPlus URP - Declarations
// Converted from Built-in RP to URP for Unity 2022.3

#ifndef KKP_DECLARATIONS_URP
#define KKP_DECLARATIONS_URP

// URP texture macros - using HLSL style declarations
#define DECLARE_TEX2D(tex) TEXTURE2D(tex); SAMPLER(sampler##tex)
#define DECLARE_TEX2D_NOSAMPLER(tex) TEXTURE2D(tex)

#define SAMPLE_TEX2D(tex,coord) SAMPLE_TEXTURE2D(tex, sampler##tex, coord)
#define SAMPLE_TEX2D_LOD(tex,coord,lod) SAMPLE_TEXTURE2D_LOD(tex, sampler##tex, coord, lod)
#define SAMPLE_TEX2D_SAMPLER(tex,samplertex,coord) SAMPLE_TEXTURE2D(tex, sampler##samplertex, coord)
#define SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord,lod) SAMPLE_TEXTURE2D_LOD(tex, sampler##samplertex, coord, lod)

float _Saturation;

float3 applySaturation(float3 col, float saturation) {
    float average = col.r * 0.2126 + col.g * 0.7152 + col.b * 0.0722;
    float adjustment = (1 - saturation) * average;
    return col * saturation + adjustment;
}

#endif
