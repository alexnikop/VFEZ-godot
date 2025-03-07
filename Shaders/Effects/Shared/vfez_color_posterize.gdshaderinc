vec3 color_posterize(vec3 color, float num_colors)
{
	color = floor(color.rgb / (1.0 / num_colors)) * (1.0 / num_colors);
	return color;
}