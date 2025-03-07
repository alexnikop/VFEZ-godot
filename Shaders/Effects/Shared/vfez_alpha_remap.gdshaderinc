float alpha_remap(float alpha, float alpha_remap_min, float alpha_remap_max)
{
	alpha = smoothstep(alpha_remap_min, alpha_remap_max, alpha);
	return alpha;
}