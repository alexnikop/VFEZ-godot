#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms color_shine;
uniform vec4 color_shine_color: source_color = vec4(1.);
uniform float color_shine_location: hint_range(0., 1.) = 0.5;
uniform float color_shine_angle: hint_range(0.0, 6.2831) = 0.;
uniform float color_shine_width: hint_range(0.0, 2.0) = 0.1;
uniform float color_shine_glow: hint_range(0., 100., 1.) = 1.;
uniform sampler2D color_shine_mask: source_color;
uniform bool color_shine_mask_red_as_alpha;
group_uniforms;

vec4 color_shine(vec4 color, vec2 uv)
{
	if (color_shine_width == 0.)
		return color;
		
	vec2 shine_uv = uv;
	shine_uv = rotate_uvs(shine_uv, color_shine_angle, vec2(1.), vec2(0.));

	float shine_mask;
		
	if (color_shine_mask_red_as_alpha)
	{
		shine_mask = texture(color_shine_mask, uv).r;	
	}
	else
	{
		shine_mask = texture(color_shine_mask, uv).a;	
	}
	
	float current_distance_proj = (shine_uv.x + shine_uv.y) / 2.;
	float white_power = 1. - 
		abs(current_distance_proj - color_shine_location) / color_shine_width;

	
	vec4 shine_color = color + color.a * white_power * color_shine_glow
		* max(sign(current_distance_proj - (color_shine_location - color_shine_width)), 0.)
		* max(sign(color_shine_location + color_shine_width - current_distance_proj), 0.)
		* color_shine_color * shine_mask;
	
	color.rgb = shine_color.rgb;
	
	return color;
}