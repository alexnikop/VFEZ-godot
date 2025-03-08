group_uniforms color_negative;
uniform float color_negative_blend: hint_range(0.0, 1.0) = 1.0;
group_uniforms;

vec3 color_negative(vec3 color)
{
	color = mix(color, 1. - color, color_negative_blend);
	return color;
}
