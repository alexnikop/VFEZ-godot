vec2 uv_shake(
	vec2 uv, 
	float uv_shake_speed, 
	float uv_shake_x, 
	float uv_shake_y)
{
	float x_shake = sin(TIME * uv_shake_speed * 50.) * uv_shake_x;
	float y_shake = cos(TIME * uv_shake_speed * 50.) * uv_shake_y;
	uv += vec2(x_shake * 0.012, y_shake * 0.01);
	return uv;
}