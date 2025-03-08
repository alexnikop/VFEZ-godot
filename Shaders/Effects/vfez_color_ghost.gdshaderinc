#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms color_ghost;
uniform float color_ghost_boost: hint_range(0.0, 5.) = 1.;
uniform float color_ghost_transparency: hint_range(0.0, 1.0) = 0.;
uniform float color_ghost_blend: hint_range(0.0, 1.0) = 1.;
group_uniforms;

vec4 color_ghost(vec4 color)
{
	float luminance = get_color_luminance(color);
	vec4 ghost;
	ghost.a = clamp(luminance - color_ghost_transparency, 0., 1.) * color.a;
	ghost.rgb = color.rgb * (luminance + color_ghost_boost);
	color = mix(color, ghost, color_ghost_blend);
	return color;
}