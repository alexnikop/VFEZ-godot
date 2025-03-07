vec2 uv_round_wave(
	vec2 uv,
	vec2 main_texture_size,
	vec2 main_texture_scale,
	float uv_round_wave_strength,
	float uv_round_wave_speed)
{
	float round_wave_x = 0.5 * main_texture_scale.x - uv.x;
	float round_wave_y = (0.5 * main_texture_scale.y - uv.y) *
		 main_texture_size.y / main_texture_size.x;
	float ripple = -sqrt(round_wave_x * round_wave_x + round_wave_y * round_wave_y);
	uv += mod(sin((ripple + TIME * (uv_round_wave_speed/10.0)) / 0.015)
		* (uv_round_wave_strength /10.0), 1.0);
	return uv;
}