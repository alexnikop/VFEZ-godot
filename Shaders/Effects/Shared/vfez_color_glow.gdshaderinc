group_uniforms color_glow;
uniform vec4 glow_color: source_color = vec4(1.);
uniform float glow_intensity = 0;
uniform float glow_intensity_global = 1;
uniform bool use_glow_texture = false;
uniform sampler2D glow_texture: source_color;
group_uniforms;

vec3 color_glow(
	vec4 color,
	vec2 uv,
	float glow_mult)
{
	float glow_mask = 1.;
	if (use_glow_texture)
	{
		glow_mask = texture(glow_texture, uv).r;
	}

	color.rgb *= glow_intensity_global * glow_mask;
	color.rgb += glow_color.rgb * glow_intensity * glow_mask * color.a * glow_mult;
	return color.rgb;
}