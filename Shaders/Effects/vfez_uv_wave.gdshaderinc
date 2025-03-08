group_uniforms uv_wave;
uniform float uv_wave_amount: hint_range(0.0, 25.0) = 7.;
uniform float uv_wave_speed: hint_range(0.0, 25.0) = 10.;
uniform float uv_wave_strength: hint_range(0.0, 25.0) = 7.5;
uniform float uv_wave_x: hint_range(0.0, 1.0) = 0.;
uniform float uv_wave_y: hint_range(0.0, 1.0) = 0.5;
group_uniforms;

vec2 uv_wave(
	vec2 uv, 
	vec2 viewport_size,
	vec2 main_texture_scale)
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