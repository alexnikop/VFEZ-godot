vec3 color_glow(
	vec4 color,
	sampler2D glow_texture,
	bool use_glow_texture,
	vec2 uv,
	vec3 glow_color,
	float glow_mult,
	float glow_intensity,
	float glow_intensity_global)
{
	float glow_mask = 1.;
	if (use_glow_texture)
	{
		glow_mask = texture(glow_texture, uv).r;
	}

	color.rgb *= glow_intensity_global * glow_mask;
	color.rgb += glow_color.rgb * glow_intensity * glow_mask * color.a * glow_mult;
	return color.rgb;
}