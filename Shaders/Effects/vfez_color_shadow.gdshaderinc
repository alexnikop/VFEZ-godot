group_uniforms color_shadow;
uniform float color_shadow_x: hint_range(-0.5, 0.5) = 0.1;
uniform float color_shadow_y: hint_range(-0.5, 0.5) = 0.1;
uniform float color_shadow_alpha: hint_range(0., 1.) = 0.5;
uniform vec3 color_shadow_color: source_color = vec3(0.);
group_uniforms;

vec4 shadow(vec4 color, sampler2D tex, vec2 uv)
{
	vec2 shadowOffset = vec2(color_shadow_x, color_shadow_y);
	float shadowA = texture(tex, uv + shadowOffset).a;
	color.rgb *= 1. - (shadowA - color.a) * (1. - color.a);
	color.rgb += color_shadow_color * shadowA * (1. - color.a);
	color = clamp(color, 0., 1.);
	color.a = max(shadowA * color_shadow_alpha, color.a);
	return color;
}
