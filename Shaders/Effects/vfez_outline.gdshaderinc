#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms outline;
uniform vec3 outline_color: source_color;
uniform float outline_alpha: hint_range(0.0, 1.0) = 1.0;
uniform float outline_glow: hint_range(1., 100, 1.) = 1.0;
uniform float outline_width;
uniform bool only_render_outline;
group_uniforms;

group_uniforms outline.pixel_perfect;
uniform bool use_pixel_perfect_outline;
uniform int outline_pixel_width;
group_uniforms;

group_uniforms outline.texture;
uniform bool use_outline_texture;
uniform sampler2D outline_texture;
uniform vec2 outline_texture_scale = vec2(1.);
uniform vec2 outline_texture_offset = vec2(0.);
uniform vec2 outline_texture_scroll_speed = vec2(0.);
group_uniforms;

group_uniforms outline.distortion;
uniform bool use_outline_distortion;
uniform sampler2D outline_distortion_texture;
uniform vec2 outline_distortion_texture_scale = vec2(1.);
uniform vec2 outline_distortion_texture_offset = vec2(0.);
uniform vec2 outline_distortion_texture_scroll_speed = vec2(0.);
uniform float outline_distortion_amount;
group_uniforms;

vec4 outline(vec4 color, vec2 texture_pixel_size, vec2 uv, sampler2D tex)
{   
    float base_tex_a = texture(tex, uv).a;;

    vec2 destUV;
    if (use_pixel_perfect_outline)
    {
        destUV = texture_pixel_size * float(outline_pixel_width);
    }
    else
    {
        destUV = texture_pixel_size * float(outline_width) * 200.;
    }

    if (use_outline_distortion)
    {
        vec2 outlineDistUV = transform_uv(
            uv,
            outline_distortion_texture_scale,
            outline_distortion_texture_offset,
            true);
        
        destUV = uv_distortion(destUV, outline_distortion_texture, outlineDistUV, 
            outline_distortion_amount, outline_distortion_texture_scroll_speed, true);;

    }

    float left = texture(tex, uv + vec2(destUV.x, 0.)).a;
    float right = texture(tex, uv - vec2(destUV.x, 0.)).a;
    float bottom = texture(tex, uv + vec2(0., destUV.y)).a;
    float top = texture(tex, uv - vec2(0., destUV.y)).a;
    float result = left + right + bottom + top;

    result = step(0.05, clamp(result, 0., 1.));

    vec4 final_outline_color = vec4(outline_color, 1.0);

    if (use_outline_texture)
    {
        vec2 outlineTexUV = transform_uv(
            uv,
            outline_texture_scale,
            outline_texture_offset,
            true);

        outlineTexUV += mod(TIME * outline_texture_scroll_speed,vec2(1.));
        outlineTexUV = fract(outlineTexUV);
        final_outline_color *= texture(outline_texture, outlineTexUV);
    }

    result *= (1. - color.a) * outline_alpha;
    vec4 outline = final_outline_color;
    outline.rgb *= outline_glow;
    outline.a = result;

    if (only_render_outline)
    {
        color = outline;
    }
    else
    {
        color = mix(color, outline, result);
    }
	
	return color;
}