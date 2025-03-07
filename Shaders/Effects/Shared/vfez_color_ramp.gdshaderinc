#ifndef VFEZ_UTILS
	#include "../vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

vec4 color_ramp(
	vec4 color,
	vec4 color_ramp_albedo,
	sampler2D color_ramp_texture,
	float color_ramp_luminosity,
	float color_ramp_blend)
{
	float luminance = get_color_luminance(color);
	float color_ramp_luminance = clamp(luminance + color_ramp_luminosity, 0., 1.);
	vec4 color_ramp_res = texture(color_ramp_texture, vec2(color_ramp_luminance)) * color_ramp_albedo;
	color.rgb = mix(color.rgb, color_ramp_res.rgb, color_ramp_blend);
	color.a = mix(color.a, clamp(color.a * color_ramp_res.a, 0., 1.), color_ramp_blend);
	return color;
}