#ifndef VFEZ_UTILS
	#include "../vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

vec4 alpha_disolve(
	vec4 color,
	float pre_disolve_alpha,
	float base_a,
	sampler2D alpha_disolve_texture,
	vec2 disolve_uv,
	float alpha_disolve_amount,
	float alpha_disolve_transition,
	float alpha_disolve_power,
	vec2 alpha_disolve_scroll_speed,
	bool use_alpha_disolve_burn,
	sampler2D alpha_disolve_burn_texture,
	vec3 alpha_disolve_burn_color,
	float alpha_disolve_burn_width,
	float alpha_disolve_burn_glow)
{
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