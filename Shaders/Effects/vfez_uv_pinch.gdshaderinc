group_uniforms uv_pinch;
uniform float uv_pinch_center_x: hint_range(0.0, 1.0) = 0.5;
uniform float uv_pinch_center_y: hint_range(0.0, 1.0) = 0.5;
uniform float uv_pinch_amount;
group_uniforms;

vec2 uv_pinch(vec2 uv, vec2 main_texture_scale)
{
	vec2 center = vec2(uv_pinch_center_x * main_texture_scale.x,
		uv_pinch_center_y * main_texture_scale.y);
	vec2 dP = uv - center;
	float pinchInt = (PI / length(center)) * (-uv_pinch_amount + 0.001);
	uv = center + normalize(dP) * atan(-length(dP) * pinchInt * 10.0)
		* 0.5 / atan(-pinchInt * 5.);
	return uv;
}