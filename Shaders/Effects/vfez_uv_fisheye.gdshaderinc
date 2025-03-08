group_uniforms uv_fisheye;
uniform float uv_fisheye_center_x: hint_range(0.0, 1.0) = 0.5;
uniform float uv_fisheye_center_y: hint_range(0.0, 1.0) = 0.5;
uniform float uv_fisheye_amount = 0.1;
group_uniforms;

vec2 uv_fisheye(vec2 uv, vec2 main_texture_scale)
{
	vec2 center = vec2(uv_fisheye_center_x * main_texture_scale.x,
					uv_fisheye_center_y * main_texture_scale.y);

	float bind = length(center);
	vec2 dF = uv - center;
	float dFlen = length(dF);
	float fishInt = (PI / bind) * (uv_fisheye_amount + 0.001);
	uv = center + (dF / max(0.0001, dFlen)) * tan(dFlen * fishInt) * bind / tan(bind * fishInt);
	return uv;
}