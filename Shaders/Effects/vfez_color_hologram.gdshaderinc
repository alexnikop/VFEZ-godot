#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms color_hologram;
uniform vec3 color_hologram_stripes_color: source_color = vec3(0,1,1);
uniform float color_hologram_stripes_amount: hint_range(0.0, 1.0) = 0.1;
uniform float color_hologram_unchanged_amount: hint_range(0.0, 1.0) = 0.0;
uniform float color_hologram_stripes_speed: hint_range(-20., 20.) = 4.5;
uniform float color_hologram_min_alpha: hint_range(0.0, 1.0) = 0.1;
uniform float color_hologram_max_alpha: hint_range(0.0, 1.0) = 0.75;
uniform float color_hologram_blend: hint_range(0.0, 1.0) = 1.;
group_uniforms;

vec4 color_hologram(vec4 color, vec2 uv)
{
	float total_hologram = color_hologram_stripes_amount +
						color_hologram_unchanged_amount;

	float hologram_y_coord = mod(uv.y + mod(TIME, 1.) * color_hologram_stripes_speed, total_hologram) / total_hologram;
	hologram_y_coord = abs(hologram_y_coord);
	float alpha = remap_float(
		clamp(hologram_y_coord - color_hologram_unchanged_amount / total_hologram, 0., 1.),
		0., 1., color_hologram_min_alpha, color_hologram_max_alpha);
	float hologram_mask = max(sign(color_hologram_unchanged_amount / total_hologram - hologram_y_coord), 0.0);
	vec4 hologram_result = color;
	hologram_result.a *= mix(alpha, 1., hologram_mask);
	hologram_result.rgb *= max(1., color_hologram_max_alpha * max (sign (hologram_y_coord - color_hologram_unchanged_amount / total_hologram), 0.0));
	hologram_mask = 1. - step(0.01, hologram_mask);
	hologram_result.rgb += hologram_mask * color_hologram_stripes_color.rgb * color.a;
	color = mix(color, hologram_result, color_hologram_blend);
	return color;
}