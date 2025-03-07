#ifndef VFEZ_UTILS
	#include "../vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

vec3 color_grading(
	vec4 color,
	vec3 color_grading_light_tone, 
	vec3 color_grading_mid_tone,
	vec3 color_grading_dark_tone,
	float color_grading_mid_point)
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
