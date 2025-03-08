#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms color_greyscale;
uniform float color_greyscale_luminosity: hint_range(-1., 1.) = 0;
uniform float color_greyscale_blend: hint_range(0., 1.) = 1.;
uniform vec3 color_greyscale_tint: source_color = vec3(1.);
group_uniforms;

vec3 color_greyscale(vec3 color)
{
	float luminance = get_color_luminance(vec4(color, 1.));
	luminance = clamp(luminance + color_greyscale_luminosity, 0., 1.);
	color = mix(color, vec3(luminance) * color_greyscale_tint, color_greyscale_blend);
	return color;
}