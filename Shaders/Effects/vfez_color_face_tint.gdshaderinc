group_uniforms color_face_tint;
uniform vec3 backface_tint_color: source_color = vec3(0.5);
uniform vec3 frontface_tint_color: source_color = vec3(1.);
group_uniforms;

vec3 color_face_tint(
	vec3 color, 
	vec3 world_normal,
	vec3 view_direction)
{
	color.rgb = mix(
		color.rgb * backface_tint_color,
		color.rgb * frontface_tint_color,
		step(0, dot(world_normal, view_direction)));
	return color;
}