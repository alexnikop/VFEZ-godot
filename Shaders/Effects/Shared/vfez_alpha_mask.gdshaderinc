float alpha_mask(
	float alpha,
	sampler2D alpha_mask_texture,
	vec2 alpha_mask_uv,
	float alpha_mask_power)
{
	//vec2 alphaMaskUV = uv;
	//alphaMaskUV = transform_uv(
		//alphaMaskUV,
		//alpha_mask_scale,
		//alpha_mask_offset,
		//false);
	vec4 alpha_mask_sample = texture(alpha_mask_texture, alpha_mask_uv);
	float mask = pow(min(alpha_mask_sample.r, alpha_mask_sample.a), alpha_mask_power);
	alpha *= mask;
	return alpha;
}