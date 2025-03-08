group_uniforms uv_round_wave;
uniform float uv_round_wave_strength: hint_range(0.0, 1.0) = 0.7;
uniform float uv_round_wave_speed: hint_range(0.0, 5.0) = 2.;
group_uniforms;

vec2 uv_round_wave(
	vec2 uv,
	vec2 main_texture_size,
	vec2 main_texture_scale)
{
	float round_wave_x = 0.5 * main_texture_scale.x - uv.x;
	float round_wave_y = (0.5 * main_texture_scale.y - uv.y) *
		 main_texture_size.y / main_texture_size.x;
	float ripple = -sqrt(round_wave_x * round_wave_x + round_wave_y * round_wave_y);
	uv += mod(sin((ripple + TIME * (uv_round_wave_speed/10.0)) / 0.015)
		* (uv_round_wave_strength /10.0), 1.0);
	return uv;
}