vec3 vertex_expand(
	vec3 vertex, 
	vec3 vertex_expand_center, 
	bool vertex_expand_ignore_center_vertical,
	float vertex_expand_amount)
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