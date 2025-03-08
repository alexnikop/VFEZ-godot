group_uniforms uv_wind;
uniform float uv_wind_speed: hint_range(0., 50.) = 2.;
uniform float uv_wind_amount: hint_range(0, 50) = 20;
uniform float uv_wind_vertical_ratio: hint_range(0.0, 1.0) = 1.;
uniform vec2 uv_radial_bend_center = vec2(0.5, 0.9);
uniform bool uv_wind_animate_manual;
uniform float uv_wind_manual_anim: hint_range(-1, 1) = 1;
uniform float uv_wind_radial_bend: hint_range(0.0, 5.0) = 0.1;
group_uniforms;

vec2 uv_wind(vec2 uv)
{
	float wind_offset;
	if (uv_wind_animate_manual)
	{
		wind_offset = uv_wind_manual_anim;
	}
	else
	{
		wind_offset = sin(TIME * uv_wind_speed * 10.);
	}
	
	uv.x = mix(uv.x, uv.x + uv_wind_amount * 0.01 * wind_offset, 
				abs(uv_wind_vertical_ratio - uv.y));
	
	vec2 delta = uv - uv_radial_bend_center;
	float delta2 = dot(delta, delta);
	float delta_offset = delta2 * wind_offset;
	uv = uv + vec2(delta.y, - delta.x) * delta_offset * uv_wind_radial_bend;
	return uv;
}
