group_uniforms chromatic_aberration;
uniform float chromatic_aberration_amount: hint_range(0.0, 1.0) = 1.;
uniform float chromatic_aberration_alpha: hint_range(0.0, 1.0) = 0.4;
group_uniforms;

vec4 chromatic_aberration(vec4 color, vec2 uv, sampler2D main_texture)
{
	vec4 r = texture(main_texture, 
		uv + vec2(chromatic_aberration_amount / 10., 0.));

	vec4 b = texture(main_texture, 
		uv + vec2(-chromatic_aberration_amount / 10., 0.));
	
	color = vec4(r.r * r.a, color.g, b.b * b.a, 
		max(max(r.a, b.a) * chromatic_aberration_alpha, color.a));
	
	return color;
}