group_uniforms uv_twist;
uniform float uv_twist_amount: hint_range(0.0, 3.1415) = 1.;
uniform float uv_twist_pos_x: hint_range(0.0, 1.0) = 0.5;
uniform float uv_twist_pos_y: hint_range(0.0, 1.0) = 0.5;
uniform float uv_twist_radius: hint_range(0.0, 3.0) = 0.75;
group_uniforms;

vec2 uv_twist(
	vec2 uv, 
	vec2 main_texture_scale)
{
	vec2 twistUV = uv - vec2(uv_twist_pos_x * main_texture_scale.x,
								uv_twist_pos_y * main_texture_scale.y);
	float twist_radius = uv_twist_radius *
			(main_texture_scale.x + main_texture_scale.y) / 2.;
	float percent = (twist_radius - length(twistUV)) / twist_radius;
	float theta = percent * percent * (2.0 * sin(uv_twist_amount)) * 8.0;
	float s = sin(theta);
	float c = cos(theta);
	float beta = max(sign(twist_radius - length(twistUV)), 0.);
	twistUV = vec2(dot(twistUV, vec2(c, -s)), dot(twistUV, vec2(s, c))) * beta + twistUV * (1. - beta);
	twistUV += vec2(uv_twist_pos_x * main_texture_scale.x,
					uv_twist_pos_y * main_texture_scale.y);
	uv = twistUV;
	return uv;
}