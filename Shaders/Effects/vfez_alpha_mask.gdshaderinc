#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms alpha_mask;
uniform sampler2D alpha_mask_texture: source_color;
uniform vec2 alpha_mask_scale = vec2(1.);
uniform vec2 alpha_mask_offset = vec2(0.);
uniform float alpha_mask_power: hint_range(0.001, 10.) = 1;
group_uniforms;

float alpha_mask(
	float alpha,
	vec2 uv,
	bool fract_uv)
{
	vec2 alpha_mask_uv = transform_uv(uv, alpha_mask_scale, alpha_mask_offset, fract_uv);
	vec4 alpha_mask_sample = texture(alpha_mask_texture, alpha_mask_uv);
	float mask = pow(min(alpha_mask_sample.r, alpha_mask_sample.a), alpha_mask_power);
	alpha *= mask;
	return alpha;
}