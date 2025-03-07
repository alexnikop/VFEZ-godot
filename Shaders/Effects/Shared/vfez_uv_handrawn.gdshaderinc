group_uniforms uv_handrawn;
uniform float uv_handrawn_amount: hint_range(0.0, 40.0) = 10.;
uniform float uv_handrawn_speed: hint_range(0.0, 30.0) = 5.;
group_uniforms;

vec2 uv_handrawn(vec2 uv)
{
	vec2 handrawnUV = uv;
	float handrawn_speed =
		floor(TIME * 20. * uv_handrawn_speed);
	handrawnUV.x = sin((handrawnUV.x * uv_handrawn_amount + handrawn_speed / 2.) * 4.);
	handrawnUV.y = sin((handrawnUV.y * uv_handrawn_amount + handrawn_speed / 2.) * 4.);
	uv = mix(uv, uv + handrawnUV, 0.0005 * uv_handrawn_amount);
	return uv;
}