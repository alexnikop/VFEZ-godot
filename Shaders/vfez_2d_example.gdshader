// this code servers as an example VFEZ2D shader
// that uses the VFEZ2D template. Files like this are
// automatically generated using the VFEZMaterial but you
// can also create them manually like the example below.

shader_type canvas_item;

#define BLEND_MIX
//#define BLEND_ADD
//#define BLEND_SUB
//#define BLEND_MUL
//#define BLEND_PREMUL_ALPHA

// #define UNSHADED
// #define LIGHT_ONLY

#define UV_POLAR
#define UV_DISTORTION
#define UV_ROTATION
#define UV_PIXELATE
#define UV_TWIST
#define UV_FISHEYE
#define UV_PINCH
#define UV_HANDRAWN
#define UV_SHAKE
#define UV_WAVE
#define UV_ROUND_WAVE
#define UV_WIND
#define UV_WRAP
#define UV_ZOOM

#define COLOR_SINGLE
#define COLOR_OVERLAY_TEXTURE
#define OUTLINE
#define OUTLINE_INNER

#define ALPHA_DISOLVE
#define CHROMATIC_ABERRATION
#define MOTION_BLUR
#define GLITCH
#define COLOR_GRADIENT
#define COLOR_RADIAL_GRADIENT
#define COLOR_TONING
#define COLOR_RAMP
#define COLOR_CHANGE
#define COLOR_GHOST
#define COLOR_HOLOGRAM
#define COLOR_POSTERIZE
#define COLOR_NEGATIVE
#define COLOR_GLOW
#define COLOR_HSV_SHIFT
#define COLOR_SHADOW
#define COLOR_GREYSCALE

#define ALPHA_MASK
#define ALPHA_REMAP
#define ALPHA_CUTOFF
#define ALPHA_CLIP
#define ALPHA_RADIAL_CLIP
#define ALPHA_FLICKER

#define PARTICLE_ANIM

#include "vfez_2d_template.gdshaderinc"