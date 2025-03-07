group_uniforms color_rim;
uniform vec4 rim_color: source_color = vec4(1.);
uniform float rim_bias: hint_range(0.0, 1.0) = 0.;
uniform float rim_scale: hint_range(0.0, 25.0) = 1.;
uniform float rim_power: hint_range(0.1, 20.0) = 5.;
uniform float rim_intensity: hint_range(0.1, 50.0) = 1.;
uniform float rim_add_amount: hint_range(0.1, 1.0) = 1.;
uniform float rim_erodes_alpha: hint_range(0.1, 2.0) = 0.;
group_uniforms;

vec4 color_rim(
	vec4 color, 
	vec3 normal, 
	vec3 view)
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