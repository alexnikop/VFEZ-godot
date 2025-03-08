#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms motion_blur;
uniform float motion_blur_angle: hint_range(-1., 1.) = 0.1;
uniform float motion_blur_dist: hint_range(-3., 3.) = 1.25;
group_uniforms;

vec3 motion_blur(vec3 color, vec2 uv, sampler2D main_texture)
{
	float angle = motion_blur_angle * PI;
	float dist = motion_blur_dist * 0.005;
	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(-dist, -dist), angle)).rgb;
	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(-dist, -dist) * 2., angle)).rgb;
	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(-dist, -dist) * 3., angle)).rgb;
	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(-dist, -dist) * 4., angle)).rgb;

	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(dist, dist), angle)).rgb;
	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(dist, dist) * 2., angle)).rgb;
	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(dist, dist) * 3., angle)).rgb;
	color.rgb += texture(main_texture,
		uv + rotate_vec2(vec2(dist, dist) * 4., angle)).rgb;

	color.rgb /= 9.;
	return color;
}