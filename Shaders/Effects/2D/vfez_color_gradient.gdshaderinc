group_uniforms color_gradient;
uniform float color_gradient_blend: hint_range(0., 1.) = 0.5;
uniform float color_gradient_boost_x: hint_range(0., 1.) = 0.5;
uniform float color_gradient_boost_y: hint_range(0., 1.) = 0.5;
uniform vec4 color_gradient_top_right_color: source_color = vec4(1,0,0,1);
uniform vec4 color_gradient_bottom_right_color: source_color = vec4(0,1,0,1);
uniform vec4 color_gradient_top_left_color: source_color = vec4(0,0,1,1);
uniform vec4 color_gradient_bottom_left_color: source_color = vec4(1,1,0,1);
group_uniforms;

vec4 color_gradient(vec4 color, vec2 uv, vec2 main_texture_scale)
{
	vec2 norm_uv = uv / main_texture_scale;
	float grad_x_mix_factor = clamp(pow(norm_uv.x, color_gradient_boost_x), 0., 1.);
	float grad_y_mix_factor = clamp(pow(norm_uv.y, color_gradient_boost_y), 0., 1.);
	vec4 grad_result = mix(
		mix(
			color_gradient_bottom_left_color,
			color_gradient_bottom_right_color,
			grad_x_mix_factor),
		mix(
			color_gradient_top_left_color,
			color_gradient_top_right_color,
			grad_x_mix_factor),
			grad_y_mix_factor
			);

	grad_result = mix(color, grad_result, color_gradient_blend);
	color.rgb = grad_result.rgb * color.a;
	color.a *= grad_result.a;
	return color;
}