group_uniforms color_single;
uniform vec3 color_single_color: source_color = vec3(1.);
uniform float color_single_blend: hint_range(0.0, 1.0) = 1.0;
group_uniforms;

vec3 color_single(vec3 color)
{
	color = mix(color, color_single_color, color_single_blend);
	return color;
}