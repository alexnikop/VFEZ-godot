#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms color_overlay_texture;
uniform sampler2D color_overlay_tex: source_color;
uniform vec2 color_overlay_tex_scale = vec2(1.);
uniform vec2 color_overlay_tex_offset = vec2(0.);
uniform vec4 color_overlay_color: source_color = vec4(1.);
uniform float color_overlay_glow: hint_range(0.0, 25) = 1.;
uniform float color_overlay_blend: hint_range(0.0, 1.0) = 1.;
uniform float color_overlay_tex_scroll_x: hint_range(-5, 5) = 0.25;
uniform float color_overlay_tex_scroll_y: hint_range(-5, 5) = 0.25;
uniform bool color_overlay_mult;
group_uniforms;

vec4 color_overlay_texture(vec4 color, vec2 uv)
{
	vec2 overlay_uv = uv;
	overlay_uv.x += TIME * color_overlay_tex_scroll_x;
	overlay_uv.y += TIME * color_overlay_tex_scroll_y;
	overlay_uv = fract(overlay_uv);
	overlay_uv = transform_uv(overlay_uv, color_overlay_tex_scale, color_overlay_tex_offset, true);
	vec4 final_overlay_color = texture(color_overlay_tex, overlay_uv);
	final_overlay_color.rgb *= color_overlay_color.rgb * color_overlay_glow;

	if (color_overlay_mult)
	{
		final_overlay_color.a *= color_overlay_color.a;
		color = mix(color, color * final_overlay_color, color_overlay_blend);
	}
	else
	{
		final_overlay_color.rgb *= final_overlay_color.a * color_overlay_color.rgb * color_overlay_color.a * color_overlay_blend;
		color.rgb += final_overlay_color.rgb;
	}

	return color;
}
