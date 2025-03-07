vec4 color_rim(
	vec4 color, 
	vec3 normal, 
	vec3 view, 
	vec4 rim_color,
	float rim_bias,
	float rim_scale,
	float rim_power,
	float rim_intensity,
	float rim_add_amount,
	float rim_erodes_alpha)
{
	float ndv = 1. - abs(dot(normal, view));
   	float rim_factor = clamp(
		rim_bias + rim_scale * pow(ndv, rim_power), 0., 1.);
    vec4 final_rim_color = rim_color * rim_factor;
    final_rim_color.rgb *= rim_intensity;
   	color.rgb = mix(
		color.rgb * (final_rim_color.rgb + vec3(1.)),
		color.rgb + final_rim_color.rgb,
		rim_add_amount);
   	color.a = clamp(
		color.a * (1. - rim_factor * rim_erodes_alpha),
		0.,
		1.);
	
	return color;
}