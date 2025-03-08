#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms alpha_disolve;
uniform sampler2D alpha_disolve_texture: source_color;
uniform vec2 alpha_disolve_texture_scale = vec2(1.);
uniform vec2 alpha_disolve_texture_offset = vec2(0.);
uniform float alpha_disolve_amount: hint_range(-0.1, 1) = -0.1;
uniform float alpha_disolve_transition: hint_range(0.01, 0.75)= 0.075;
uniform float alpha_disolve_power: hint_range(0.001, 10) = 1;
uniform vec2 alpha_disolve_scroll_speed;
group_uniforms;

// disolve burn
group_uniforms alpha_disolve.disolve_burn;
uniform bool use_alpha_disolve_burn = false;
uniform sampler2D alpha_disolve_burn_texture: source_color;
uniform vec3 alpha_disolve_burn_color: source_color = vec3(1., 1., 0.);
uniform float alpha_disolve_burn_width: hint_range(0.0, 0.2) = 0.01;
uniform float alpha_disolve_burn_glow: hint_range(1, 250) = 5;
group_uniforms;

vec4 alpha_disolve(
	vec4 color,
	float pre_disolve_alpha,
	float base_a,
	vec2 uv,
	bool fract_uv)
{
	vec2 disolve_uv = transform_uv(uv, alpha_disolve_texture_scale, alpha_disolve_texture_offset, fract_uv);

	float disolve_amount = clamp(alpha_disolve_amount + (1. - base_a), 0., 1.);
	float disolve_transition = max(0.01, alpha_disolve_transition * ease_out_quint(disolve_amount));
	disolve_uv += mod(TIME * alpha_disolve_scroll_speed, 1.0);
	disolve_amount = clamp(pow(disolve_amount, alpha_disolve_power), 0., 1.);
	float disolve_sample = texture(alpha_disolve_texture, disolve_uv).r;
	float disolve = clamp(
		smoothstep(
				0.0,
				disolve_transition,
				remap_float(1.0 - disolve_amount, 0.0, 1.0, -1.0, 1.0) + disolve_sample
		), 0., 1.);

	color.a *= disolve;

	if (use_alpha_disolve_burn)
	{
		float disolve_burn = clamp(
				smoothstep(
					0.,
					disolve_transition + alpha_disolve_burn_width,
					remap_float(1.0 - disolve_amount, 0.0, 1.0, -1.0, 1.0) + disolve_sample
				), 0., 1.
			);

		disolve_burn = disolve - disolve_burn;
		vec3 disolve_burn_color = alpha_disolve_burn_color.rgb * alpha_disolve_burn_glow;

		color.rgb += disolve_burn *
				texture(alpha_disolve_burn_texture, disolve_uv).rgb
				* disolve_burn_color.rgb
				* pre_disolve_alpha;
	}
	return color;
}