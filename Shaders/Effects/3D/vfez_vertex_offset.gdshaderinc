vec3 vertex_offset(
	vec3 vertex, 
	vec3 normal, 
	vec2 uv, 
	sampler2D vertex_offset_texture,
	float vertex_offset_amount,
	float vertex_offset_power,
	vec2 vertex_offset_speed)
{
	vec2 offsetUV = uv;
	offsetUV += mod(TIME * vertex_offset_speed, 1.0);
	float offset = textureLod(vertex_offset_texture, offsetUV, 0.).r;
	vertex = vertex + normal * vertex_offset_amount * pow(offset, vertex_offset_power);
	return vertex;
}