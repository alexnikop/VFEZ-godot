group_uniforms uv_shake;
uniform float uv_shake_speed: hint_range(0.0, 50.0) = 20.;
uniform float uv_shake_x: hint_range(-15., 15) = 5;
uniform float uv_shake_y: hint_range(-15., 15) = 4;
group_uniforms;

vec2 uv_shake(
	vec2 uv)
{
	float x_shake = sin(TIME * uv_shake_speed * 50.) * uv_shake_x;
	float y_shake = cos(TIME * uv_shake_speed * 50.) * uv_shake_y;
	uv += vec2(x_shake * 0.012, y_shake * 0.01);
	return uv;
}