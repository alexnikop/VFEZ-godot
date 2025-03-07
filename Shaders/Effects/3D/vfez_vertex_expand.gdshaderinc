group_uniforms vertex_expand;
uniform vec3 vertex_expand_center = vec3(0.);
uniform bool vertex_expand_ignore_center_vertical = false;
uniform float vertex_expand_amount: hint_range(0.0, 10.) = 0.5;
group_uniforms;

vec3 vertex_expand(
	vec3 vertex)
{
	vec3 final_expand_center = vertex_expand_center;
	if (vertex_expand_ignore_center_vertical)
	{
		final_expand_center.z = vertex.z;
	}
	vec3 expand_dir = normalize(vertex - final_expand_center);
	vertex += expand_dir * vertex_expand_amount;
	return vertex;
}