group_uniforms color_posterize;
uniform float color_posterize_num_colors: hint_range(0.0, 30.) = 5.;
group_uniforms;

vec3 color_posterize(vec3 color)
{
	color = floor(color.rgb / (1.0 / color_posterize_num_colors)) * (1.0 / color_posterize_num_colors);
	return color;
}