vec2 uv_wave(
	vec2 uv, 
	vec2 viewport_size,
	vec2 main_texture_scale,
	float uv_wave_amount,
	float uv_wave_speed,
	float uv_wave_strength,
	float uv_wave_x,
	float uv_wave_y)
{
	vec2 waveUV = vec2(uv_wave_x * main_texture_scale.x,
					uv_wave_y * main_texture_scale.y) - uv;
	waveUV.x *= viewport_size.x / viewport_size.y;
	float ang_wave =
		(sqrt(dot(waveUV, waveUV)) * uv_wave_amount)
		- mod(TIME * uv_wave_speed, 360.0);
	uv = uv + normalize(waveUV) * sin(ang_wave) * (uv_wave_strength / 1000.);
	return uv;	
}