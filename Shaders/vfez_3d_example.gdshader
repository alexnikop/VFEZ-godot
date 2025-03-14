// this code servers as an example VFEZ3D shader
// that uses the VFEZ3D template. Files like this are
// automatically generated using the VFEZMaterial but you
// can also create them manually like the example below.

shader_type spatial;

#define BLEND_MIX
//#define BLEND_ADD
//#define BLEND_SUB
//#define BLEND_MUL
//#define BLEND_PREMUL_ALPHA

#define DEPTH_DRAW_OPAQUE
//#define DEPTH_DRAW_ALWAYS
//#define DEPTH_DRAW_NEVER

#define CULL_BACK
//#define CULL_FRONT
//#define CULL_DISABLED

#define DIFFUSE_LAMBERT
//#define DIFFUSE_LABERT_WRAP
//#define DIFFUSE_BURLEY
//#define DIFFUSE_TOON

#define SPECULAR_SCHLICK_GGX
//#define SPECULAR_TOON
//#define SPECULAR_DISABLED

#define UNSHADED

//#define BILLBOARD_ENABLED
//#define BILLBOARD_Y
//#define BILLBOARD_PARTICLE
//#define BILLBOARD_KEEP_SCALE

//#define NO_DEPTH_TEST

//#define PARTICLE_TRAILS
//#define PARTICLE_ANIM

// enable more shapes to blend more textures
#define SHAPE2
#define SHAPE3

#define UV_PIXELATE
#define UV_TWIST
#define UV_HANDRAWN
#define UV_SHAKE
#define UV_WAVE
#define UV_ROUND_WAVE
#define UV_GLOBAL_DISTORTION

#define ALPHA_DISOLVE

#define COLOR_FACE_TINT
#define COLOR_TONING
#define COLOR_RAMP
#define COLOR_POSTERIZE
#define COLOR_RIM
#define COLOR_GLOW
#define COLOR_HSV_SHIFT

#define ALPHA_MASK
#define ALPHA_REMAP
#define ALPHA_CUTOFF

#define VERTEX_OFFSET
#define VERTEX_EXPAND

#define SHADE_NORMAL_MAP

#include "vfez_3d_template.gdshaderinc"
