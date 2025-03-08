group_uniforms alpha_flicker;
uniform float alpha_flicker_percent: hint_range(0., 1.) = 0.05;
uniform float alpha_flicker_frequency: hint_range(0., 5.) = 0.2;
uniform float alpha_flicker_value: hint_range(0.0, 1.0) = 0.;
group_uniforms;

float alpha_flicker(float alpha)
{
	alpha *= clamp(
		alpha * step(fract(0.05 + TIME * alpha_flicker_frequency),
		1. - alpha_flicker_percent) + alpha_flicker_value, 0., 1.);
	return alpha;
}