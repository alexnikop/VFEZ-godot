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
// #define LIGHT_ONLYE

#define COLOR_FACE_TINT
#define COLOR_GRADING
#define COLOR_RAMP
#define COLOR_POSTERIZE
#define COLOR_RIM
#define COLOR_GLOW
#define COLOR_HSV_SHIFT

#define ALPHA_DISOLVE
#define ALPHA_MASK
#define ALPHA_REMAP
#define ALPHA_CUTOFF

#define UV_PIXELATE
#define UV_TWIST
#define UV_HANDRAWN
#define UV_SHAKE
#define UV_WAVE
#define UV_ROUND_WAVE
#define UV_GLOBAL_DISTORTION

#define VERTEX_OFFSET
#define VERTEX_EXPAND

#include "vfez_2d_template.gdshaderinc"