# KKShadersPlus URP Conversion

### This project is for my character card render tools to directly import character cards to Unity. will be open source soon. 
### Most of shaders not working properly at this time! I'm researching how to fix them


This folder contains the Universal Render Pipeline (URP) conversion of the KKShadersPlus shaders for Unity 2022.3.

## Conversion Status

### ✅ Fully Converted (Core Shaders)

#### Core Include Files (.hlsl)
| File | Description | Status |
|------|-------------|--------|
| `KKPDeclarations.hlsl` | Core texture sampling macros for URP | ✅ |
| `KKPCommon.hlsl` | Compatibility layer between Built-in RP and URP | ✅ |
| `KKPVertexLights.hlsl` | Additional lights handling using URP's GetAdditionalLight() | ✅ |
| `KKPVertexLightsSpecular.hlsl` | Specular calculations for additional lights | ✅ |
| `KKPEmission.hlsl` | Emission mask handling | ✅ |
| `KKPCoom.hlsl` | Liquid/cum effects | ✅ |
| `KKPLighting.hlsl` | Core lighting and shadow functions | ✅ |
| `KKPReflect.hlsl` | Reflection and matcap handling | ✅ |
| `KKPDisplace.hlsl` | Vertex displacement for tessellation | ✅ |

#### Hair Shaders
| Original Shader | URP Shader Path | Status |
|----------------|-----------------|--------|
| HairPlus | `xukmi/URP/HairPlus` | ✅ |
| HairFrontPlus | `xukmi/URP/HairFrontPlus` | ✅ |
| HairPlusReflect | Built into HairPlus (use KKPReflect.hlsl) | ✅ |
| HairFrontPlusReflect | Built into HairFrontPlus (use KKPReflect.hlsl) | ✅ |

#### Skin Shaders
| Original Shader | URP Shader Path | Status |
|----------------|-----------------|--------|
| SkinPlus | `xukmi/URP/SkinPlus` | ✅ |
| SkinPlusReflect | Built into SkinPlus (use KKPReflect.hlsl) | ✅ |

#### Eye Shaders
| Original Shader | URP Shader Path | Status |
|----------------|-----------------|--------|
| EyePlus | `xukmi/URP/EyePlus` | ✅ |
| EyeWPlus | `xukmi/URP/EyeWPlus` | ✅ |

#### Item/Clothing Shaders
| Original Shader | URP Shader Path | Status |
|----------------|-----------------|--------|
| MainItemPlus | `xukmi/URP/MainItemPlus` | ✅ |
| MainAlphaPlus | `xukmi/URP/MainAlphaPlus` | ✅ |
| MainOpaquePlus | `xukmi/URP/MainOpaquePlus` | ✅ |

### ⚠️ Not Converted (Tessellation Shaders)
Tessellation shaders require different handling in URP and are not fully converted:
- `*Tess*.shader` variants - Tessellation requires compute shaders or shader graph in URP
- These would need Unity 2022.3+ with special tessellation support enabled

### 📝 Notes on Reflect Shader Variants
In the Built-in RP, the `*Reflect` shaders used a separate pass for reflections. In URP, reflections are now handled in the main forward pass using:
- `GlossyEnvironmentReflection()` for environment reflections
- Matcap sampling via `KKPReflect.hlsl`

To enable reflections in URP shaders, ensure the reflection properties are set correctly in the material.

## Key Differences from Built-in RP

### LightMode Tags
- `ForwardBase` → `UniversalForward`
- `ForwardAdd` → Not used (URP uses single pass with additional lights)
- `ShadowCaster` → `ShadowCaster` (same)
- Outline pass uses `SRPDefaultUnlit`

### Includes
```hlsl
// Old (Built-in RP)
#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "Lighting.cginc"

// New (URP)
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
```

### Main Light Access
```hlsl
// Old (Built-in RP)
_LightColor0
_WorldSpaceLightPos0

// New (URP)
Light mainLight = GetMainLight();
float3 mainLightColor = mainLight.color;
float3 worldLightDir = normalize(mainLight.direction);
```

### Shadow Handling
```hlsl
// Old (Built-in RP)
#ifdef SHADOWS_SCREEN
    float4 shadowMap = tex2D(_ShadowMapTexture, shadowMapUV);
#endif

// New (URP)
#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
    float shadowAttenuation = MainLightRealtimeShadow(shadowCoord);
#endif
```

### Additional Lights (Vertex Lights)
```hlsl
// Old (Built-in RP)
#ifdef VERTEXLIGHT_ON
    // Uses unity_4LightPosX0, etc.
#endif

// New (URP)
#ifdef _ADDITIONAL_LIGHTS
    uint count = GetAdditionalLightsCount();
    Light additionalLight = GetAdditionalLight(i, posWS);
#endif
```

## Usage

1. Ensure your Unity project is using URP
2. Copy the `Shaders_URP` folder to your project's Assets folder
3. Assign the new shaders to your materials (they are prefixed with `xukmi/URP/`)

## Shader Keywords

The following multi_compile keywords are used:
- `_MAIN_LIGHT_SHADOWS` / `_MAIN_LIGHT_SHADOWS_CASCADE` - Main light shadows
- `_ADDITIONAL_LIGHTS_VERTEX` / `_ADDITIONAL_LIGHTS` - Additional light support
- `_SHADOWS_SOFT` - Soft shadows
- `LIGHTMAP_ON` - Lightmap support

## Notes

- Tessellation shaders (`*Tess*.shader`) require additional work for URP and are not fully converted
- Reflection shaders (`*Reflect*.shader`) use `GlossyEnvironmentReflection` instead of `UNITY_SAMPLE_TEXCUBE_LOD`
- The outline pass now uses `SRPDefaultUnlit` tag which renders after the main pass

## Original Shaders

The original Built-in RP shaders are preserved in the `../Shaders` folder for reference.

## Version

- Unity: 2022.3 LTS
- URP: Compatible with URP 14.x+
- Converted: January 2026
