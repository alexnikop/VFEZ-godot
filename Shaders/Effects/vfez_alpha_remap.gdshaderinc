group_uniforms alpha_remap;
uniform float alpha_remap_min: hint_range(0.0, 1.0) = 0;
uniform float alpha_remap_max: hint_range(0.0, 1.0) = 0.075;
group_uniforms;

float alpha_remap(float alpha)
{
	alpha = smoothstep(alpha_remap_min, alpha_remap_max, alpha);
	return alpha;
}