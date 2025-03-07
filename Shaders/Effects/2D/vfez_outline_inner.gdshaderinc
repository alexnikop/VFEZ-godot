group_uniforms outline_inner;
uniform bool only_render_inner_outline;
uniform vec3 outline_inner_color: source_color;
uniform float outline_inner_thickness: hint_range(0., 5.) = 1.;
uniform float outline_inner_alpha: hint_range(0., 1.) = 1.;
uniform float ouline_inner_glow: hint_range(1., 10.) = 1.;
group_uniforms;

vec3 get_pixel(float offsetX, float offsetY, vec2 uv, sampler2D tex, vec2 texture_pixel_size)
{
	return texture(tex, (uv + vec2(offsetX * texture_pixel_size.x, offsetY * texture_pixel_size.y))).rgb;
}


vec4 outline_inner(vec4 color, vec2 texture_pixel_size, vec2 uv, sampler2D tex)
{
	vec3 innerT = abs(
			get_pixel(0., outline_inner_thickness, uv, tex, texture_pixel_size) - 
			get_pixel(0., - outline_inner_thickness, uv, tex, texture_pixel_size)
	);
	
	innerT += abs(
		get_pixel(outline_inner_thickness, 0., uv, tex, texture_pixel_size) - 
		get_pixel(-outline_inner_thickness, 0., uv, tex, texture_pixel_size)
	);
	
	if (only_render_inner_outline)
	{
		innerT *= color.a * outline_inner_alpha;
		color.rgb = length(innerT) * outline_inner_color * ouline_inner_glow;
		color.a = step(0.3, color.r + color.g + color.b);
	}
	else
	{
		innerT = innerT / 2.0 * color.a * outline_inner_alpha;
		color.rgb += length(innerT) * outline_inner_color * ouline_inner_glow;
	}
	
	return color;
}	
