#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif


group_uniforms color_change.color1;
uniform bool change_color_1;
uniform vec3 color_1_to_change: source_color;
uniform vec3 color_1_to_replace: source_color;
uniform float color_1_change_tolerance: hint_range(0.0, 1.0) = 0.1;
group_uniforms;

group_uniforms color_change.color2;
uniform bool change_color_2;
uniform vec3 color_2_to_change: source_color;
uniform vec3 color_2_to_replace: source_color;
uniform float color_2_change_tolerance: hint_range(0.0, 1.0) = 0.1;
group_uniforms;

group_uniforms color_change.color3;
uniform bool change_color_3;
uniform vec3 color_3_to_change: source_color;
uniform vec3 color_3_to_replace: source_color;
uniform float color_3_change_tolerance: hint_range(0.0, 1.0) = 0.1;
group_uniforms;

vec3 change_single_color(
	vec3 color,
	vec3 color_to_change,
	vec3 color_to_replace,
	float color_change_tolerance)
{
	vec3 dif = abs(color - color_to_change.rgb);
	color.rgb = mix(color, color_to_replace.rgb,
		max(sign(color_change_tolerance * 3. - dif.x - dif.y - dif.z), 0.0));
	return color;
}

vec3 color_change(vec3 color)
{
	color = clamp(color, 0., 1.);
	
	if (change_color_1)
	{
		color = change_single_color(
			color,
			color_1_to_change,
			color_1_to_replace,
			color_1_change_tolerance);
	}

	if (change_color_2)
	{
		color = change_single_color(
			color,
			color_2_to_change,
			color_2_to_replace,
			color_2_change_tolerance);
	}

	if (change_color_3)
	{
		color = change_single_color(
			color,
			color_3_to_change,
			color_3_to_replace,
			color_3_change_tolerance);
	}
	return color;
}