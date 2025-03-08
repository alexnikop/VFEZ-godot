group_uniforms alpha_radial_clip;
uniform float alpha_radial_clip_start_angle: hint_range(0.0, 360., 1.);
uniform float alpha_radial_clip_one: hint_range(0.0, 360., 1.);
uniform float alpha_radial_clip_two: hint_range(0.0, 360., 1.);
group_uniforms;

float alpha_radial_clip(float alpha, vec2 uv, vec2 main_texture_scale)
{
	vec2 norm_uv = uv / main_texture_scale;
	float start_angle = alpha_radial_clip_start_angle - alpha_radial_clip_one;
    float end_angle = alpha_radial_clip_start_angle + alpha_radial_clip_two;
    float offset_0 = clamp(0., 360., start_angle + 360.);
    float offset_360 = clamp(0., 360., end_angle - 360.);
    vec2 atan2Coord = vec2(mix(-1., 1., norm_uv.x), mix(-1., 1., norm_uv.y));
    float a_tan_angle = atan(atan2Coord.y, atan2Coord.x) * 57.3;
	if (a_tan_angle < 0.) 
		a_tan_angle = 360. + a_tan_angle;
	
	if (a_tan_angle >= start_angle && a_tan_angle <= end_angle)
		return 0.;
	
	if (a_tan_angle <= offset_360)
		return 0.;		
	
	if (a_tan_angle >= offset_0)
		return 0.;
	return alpha;
}
