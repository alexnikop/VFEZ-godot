group_uniforms color_radial_gradient;
uniform vec2 color_radial_gradient_center = vec2(0.5);
uniform float color_radial_gradient_blend: hint_range(0., 1.) = 0.5;
uniform float color_radial_gradient_boost: hint_range(0., 1.) = 0.5;
uniform vec4 color_radial_gradient_color_one: source_color = vec4(1,0,0,1);
uniform vec4 color_radial_gradient_color_two: source_color = vec4(0,1,0,1);
group_uniforms;

vec4 color_radial_gradient(vec4 color, vec2 uv, vec2 main_texture_scale, vec2 viewport_size)
{
	vec2 norm_uv = uv / main_texture_scale;
	float radial_dist = 1. - length(norm_uv - color_radial_gradient_center);
	radial_dist*= viewport_size.x / viewport_size.y;
	radial_dist = clamp(color_radial_gradient_boost * radial_dist, 0., 1.);
	vec4 grad_result = mix(
		color_radial_gradient_color_one, 
		color_radial_gradient_color_two, 
		radial_dist);
	
	grad_result = mix(color, grad_result, color_radial_gradient_blend);
	color.rgb = grad_result.rgb * color.a;
	color.a *= grad_result.a;
	return color;
}