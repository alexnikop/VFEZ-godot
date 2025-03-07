vec2 uv_distortion(
	vec2 uv,
	sampler2D distortion_texture,
	vec2 distortion_uv,
	float distortion_amount,
	vec2 distortion_speed,
	bool fract_result)
{
	distortion_uv += mod(TIME * distortion_speed, vec2(1.));
	if (fract_result)
	{
		distortion_uv = fract(distortion_uv);
	}

	float distortAmount =
		(texture(distortion_texture, distortion_uv).r - 0.5) * 0.2 * distortion_amount;
	uv += vec2(1.) * distortAmount;
	return uv;
}