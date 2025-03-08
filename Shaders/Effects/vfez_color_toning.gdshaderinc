#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms color_toning;
uniform vec3 color_grading_light_tone: source_color;
uniform vec3 color_grading_mid_tone: source_color;
uniform vec3 color_grading_dark_tone: source_color;
uniform float color_grading_mid_point: hint_range(0.0, 1.0) = 0.5;
group_uniforms;

vec3 color_toning(vec4 color)
{
	float luminance = get_color_luminance(color);
	
	vec3 color_grading_dark_middle_mix = mix(
		color_grading_dark_tone,
		color_grading_mid_tone,
		luminance / color_grading_mid_point
	);

	vec3 color_grading_middle_light_mix = mix(
		color_grading_mid_tone,
		color_grading_light_tone,
		(luminance - color_grading_mid_point) / (1.0 - color_grading_mid_point)
	);

	color.rgb *= mix(
		color_grading_dark_middle_mix,
		color_grading_middle_light_mix,
		step(color_grading_mid_point, luminance)
	);
	
	return color.rgb;
}
