group_uniforms alpha_clip;
uniform float alpha_clip_left: hint_range(0.0, 1.0) = 0;
uniform float alpha_clip_right: hint_range(0.0, 1.0) = 0;
uniform float alpha_clip_up: hint_range(0.0, 1.0) = 0;
uniform float alpha_clip_down: hint_range(0.0, 1.0) = 0;
group_uniforms;

float alpha_clip(float alpha, vec2 uv, vec2 main_texture_scale)
{
	vec2 norm_uv = uv / main_texture_scale;
	
	if (1. - alpha_clip_up - norm_uv.y < 0.)
		return 0.;
		
	if (norm_uv.y - alpha_clip_down < 0.)
		return 0.;
	
	if (1. - alpha_clip_right - norm_uv.x < 0.)
		return 0.;
	
	if (norm_uv.x - alpha_clip_left < 0.)
		return 0.;
		
	return alpha;
}