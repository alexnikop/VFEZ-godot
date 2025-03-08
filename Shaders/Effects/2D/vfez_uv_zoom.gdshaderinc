group_uniforms uv_zoom;
uniform vec2 uv_zoom_center = vec2(0.5);
uniform float uv_zoom_amount: hint_range(0.1, 5.) = 0.5;
group_uniforms;

vec2 uv_zoom(vec2 uv, vec2 main_texture_scale)
{
	vec2 norm_center = uv_zoom_center / main_texture_scale;
	uv -= norm_center;
	uv = uv * uv_zoom_amount;
	uv += norm_center;
	return uv;
}