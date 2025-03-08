group_uniforms uv_wrap;
uniform float uv_wrap_strength: hint_range(0.0, 0.1) = 0.025;
uniform float uv_wrap_speed: hint_range(0.0, 25.) = 8;
uniform float uv_wrap_scale: hint_range(0.05, 3.) = 0.5;
group_uniforms;

vec2 uv_wrap(vec2 uv, vec2 main_texture_scale)
{
	vec2 norm_uv = uv / main_texture_scale;
	float x_wrap = TIME * uv_wrap_speed + norm_uv.x * TAU / uv_wrap_scale;
	float y_wrap = TIME * uv_wrap_speed + norm_uv.y * TAU / uv_wrap_scale;
	vec2 wrap = vec2(sin(x_wrap), cos(y_wrap)) * uv_wrap_strength;
	uv += wrap;
	return uv;
}