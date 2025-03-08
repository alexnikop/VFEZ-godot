group_uniforms vertex_offset;
uniform sampler2D vertex_offset_texture: source_color;
uniform float vertex_offset_amount: hint_range(0.0, 2.) = 0.5;
uniform float vertex_offset_power: hint_range(0.01, 10.) = 1.;
uniform vec2 vertex_offset_speed;
group_uniforms;

vec3 vertex_offset(
	vec3 vertex, 
	vec3 normal, 
	vec2 uv)
{
	vec2 offsetUV = uv;
	offsetUV += mod(TIME * vertex_offset_speed, 1.0);
	float offset = textureLod(vertex_offset_texture, offsetUV, 0.).r;
	vertex = vertex + normal * vertex_offset_amount * pow(offset, vertex_offset_power);
	return vertex;
}