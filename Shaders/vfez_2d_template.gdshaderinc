// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// THE CODE BELOW IS NOT INTENDED TO BE CHANGED MANUALLY.
// MANUAL CHANGES MIGHT CAUSE THE VFEZ MATERIAL TO WORK INCORRECTLY.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// shader code starts here -----------------------------------------------

#include "Effects/vfez_utils.gdshaderinc"

#if defined(UNSHADED)
	render_mode unshaded;
#elif defined(LIGHT_ONLY)
	render_mode light_only;
#endif

#if defined(BLEND_MIX)
	render_mode blend_mix;
#elif defined(BLEND_ADD)
	render_mode blend_add;
#elif defined(BLEND_SUB)
	render_mode blend_sub;
#elif defined(BLEND_MUL)
	render_mode blend_mul;
#elif defined(BLEND_PREMUL_ALPHA)
	render_mode blend_premul_alpha;
#endif

group_uniforms base;
uniform vec2 texture_scale = vec2(1.);
uniform vec2 texture_offset = vec2(0.);
uniform vec2 texture_scroll_speed = vec2(0.);
uniform bool apply_scale_offset_after_uv_effects;
uniform vec4 texture_color: source_color = vec4(1.);
uniform float texture_alpha: hint_range(0.0, 1.0) = 1.;
uniform bool texture_red_as_alpha = false;
uniform bool premultiply_color = false;
uniform bool premultiply_alpha = false;
uniform float contrast: hint_range(0.0, 10) = 1.;
uniform float brightness: hint_range(-1., 1.) = 0.;
group_uniforms;

group_uniforms outline;
uniform bool use_outline;
group_uniforms;
#if defined(OUTLINE)
	#include "Effects/2D/vfez_outline.gdshaderinc"
#endif

group_uniforms rect_size;
uniform float rect_size_ratio: hint_range(1.0, 5.0) = 1.0;
group_uniforms;

group_uniforms color_grading;
uniform bool use_color_grading = false;
group_uniforms;
#if defined(COLOR_GRADING)
	#include "Effects/Shared/vfez_color_grading.gdshaderinc"
#endif

group_uniforms color_ramp;
uniform bool use_color_ramp = false;
group_uniforms;
#if defined(COLOR_RAMP)
	#include "Effects/Shared/vfez_color_ramp.gdshaderinc"
#endif

group_uniforms color_posterize;
uniform bool use_color_posterize = false;
group_uniforms;
#if defined(COLOR_POSTERIZE)
	#include "Effects/Shared/vfez_color_posterize.gdshaderinc"
#endif

group_uniforms color_glow;
uniform bool use_color_glow = false;
group_uniforms;
#if defined(COLOR_GLOW)
	#include "Effects/Shared/vfez_color_glow.gdshaderinc"
#endif

group_uniforms color_hsv_shift;
uniform bool use_color_hsv_shift = false;
group_uniforms;
#if defined(COLOR_HSV_SHIFT)
	#include "Effects/Shared/vfez_hsv_shift.gdshaderinc"
#endif

group_uniforms color_shadow;
uniform bool use_color_shadow = false;
group_uniforms;
#if defined(COLOR_SHADOW)
	#include "Effects/2D/vfez_color_shadow.gdshaderinc"
#endif


group_uniforms alpha_disolve;
uniform bool use_alpha_disolve = false;
group_uniforms;
#if defined(ALPHA_DISOLVE)
	#include "Effects/Shared/vfez_alpha_disolve.gdshaderinc"
#endif


group_uniforms alpha_mask;
uniform bool use_alpha_mask = false;
group_uniforms;
#if defined(ALPHA_MASK)
	#include "Effects/Shared/vfez_alpha_mask.gdshaderinc"
#endif

group_uniforms alpha_remap;
uniform bool use_alpha_remap = false;
group_uniforms alpha_remap;
#if defined(ALPHA_REMAP)
	#include "Effects/Shared/vfez_alpha_remap.gdshaderinc"
#endif

group_uniforms alpha_cutoff;
uniform bool use_alpha_cutoff = false;
group_uniforms;
#if defined(ALPHA_CUTOFF)
	#include "Effects/Shared/vfez_alpha_cutoff.gdshaderinc"
#endif

group_uniforms uv_rotation;
uniform bool use_uv_rotation;
#if defined(UV_ROTATION)
	uniform float uv_rotation_offset: hint_range(0.0, 6.28318530718) = 0.;
	uniform float uv_rotation_speed = 0.;
#endif
group_uniforms;

group_uniforms uv_distortion;
uniform bool use_uv_distortion;
#if defined(UV_DISTORTION)
	uniform sampler2D distortion_tex: source_color;
	uniform vec2 distortion_tex_scale = vec2(1.);
	uniform vec2 distortion_tex_offset = vec2(0.);
	uniform float distortion_amount: hint_range(0.0, 10) = 0.0;
	uniform vec2 distortion_speed = vec2(0.1);
#endif
group_uniforms;

group_uniforms uv_polar;
uniform bool use_uv_polar = false;
#if defined(UV_POLAR)
	uniform vec2 uv_polar_center = vec2(0.5);
	uniform bool distortion_uses_uv_polar = false;
#endif
group_uniforms;

group_uniforms uv_pixelate;
uniform bool use_uv_pixelate = false;
group_uniforms;
#if defined(UV_PIXELATE)
	#include "Effects/Shared/vfez_uv_pixelate.gdshaderinc"
#endif

group_uniforms uv_twist;
uniform bool use_uv_twist = false;
group_uniforms;
#if defined(UV_TWIST)
	#include "Effects/Shared/vfez_uv_twist.gdshaderinc"
#endif


group_uniforms uv_handrawn;
uniform bool use_uv_handrawn = false;
group_uniforms;
#if defined(UV_HANDRAWN)
	#include "Effects/Shared/vfez_uv_handrawn.gdshaderinc"
#endif

group_uniforms uv_shake;
uniform bool use_uv_shake = false;
group_uniforms;
#if defined(UV_SHAKE)
	#include "Effects/Shared/vfez_uv_shake.gdshaderinc"
#endif


group_uniforms uv_wave;
uniform bool use_uv_wave = false;
group_uniforms;
#if defined(UV_WAVE)
	#include "Effects/Shared/vfez_uv_wave.gdshaderinc"
#endif


group_uniforms uv_round_wave;
uniform bool use_uv_round_wave = false;
group_uniforms;
#if defined(UV_ROUND_WAVE)
	#include "Effects/Shared/vfez_uv_round_wave.gdshaderinc"
#endif


group_uniforms particle.particle_anim;
uniform bool use_particle_anim = false;
group_uniforms;

#if defined(PARTICLE_ANIM)
	#include "Effects/Shared/vfez_particle_anim.gdshaderinc"
#endif

void vertex() {
	#if defined(PARTICLE_ANIM)
		if (use_particle_anim)
		{
			UV = particle_anim(INSTANCE_CUSTOM.z, UV);
		}
	#endif

	VERTEX += VERTEX * (rect_size_ratio - 1.0);
}

void fragment() {
	vec2 baseUV = UV;

	baseUV = baseUV * rect_size_ratio + vec2(-rect_size_ratio * 0.5 + 0.5);

	if (!apply_scale_offset_after_uv_effects)
		baseUV = transform_uv(
						baseUV,
						texture_scale,
						texture_offset,
						true);

	#if defined(UV_PIXELATE)
		if (use_uv_pixelate)
		{
			vec2 texture_size = 1. / TEXTURE_PIXEL_SIZE;
			baseUV = uv_pixelate(baseUV, texture_size);
		}
	#endif

	#if defined(UV_TWIST)
		if (use_uv_twist)
		{
			baseUV = uv_twist(baseUV, texture_scale);
		}
	#endif

	#if defined(UV_HANDRAWN)
		if (use_uv_handrawn)
		{
			baseUV = uv_handrawn(baseUV);
		}
	#endif

	#if defined(UV_SHAKE)
		if (use_uv_shake)
		{
			baseUV = uv_shake(baseUV);
		}
	#endif

	#if defined(UV_WAVE)
		if (use_uv_wave)
		{
			vec2 texture_size = 1. / TEXTURE_PIXEL_SIZE;
			baseUV = uv_wave(baseUV, texture_size, texture_scale);
		}
	#endif

	#if defined(UV_ROUND_WAVE)
		if (use_uv_round_wave)
		{
			vec2 main_tex_size = vec2(textureSize(TEXTURE, 0));
			baseUV = uv_round_wave(baseUV, main_tex_size, texture_scale);
		}
	#endif

	#if defined(UV_POLAR)
		if (use_uv_polar)
		{
			baseUV = uv_polar(baseUV, uv_polar_center);
		}
	#endif

	#if defined(UV_DISTORTION)
		if (use_uv_distortion && distortion_amount > 0.)
		{
			vec2 distort_uvs = baseUV;

			//distort_uvs
			vec2 distortionUV = baseUV;
			distortionUV = transform_uv(
							distortionUV,
							distortion_tex_scale,
							distortion_tex_offset,
							true);

			#if defined(UV_POLAR)
				if (use_uv_polar && distortion_uses_uv_polar)
				{
					distortionUV = uv_polar(distortionUV, uv_polar_center);
				}
			#endif

			baseUV = uv_distortion(baseUV, distortion_tex, distortionUV, distortion_amount, distortion_speed, true);
		}
	#endif

	#if defined(UV_ROTATION)
	if (use_uv_rotation)
	{
		baseUV = rotate_uvs(
			baseUV,
			uv_rotation_offset + mod(uv_rotation_speed * TIME, TAU),
			texture_scale,
			texture_offset);
	}
	#endif


	if (apply_scale_offset_after_uv_effects)
		baseUV = transform_uv(
						baseUV,
						texture_scale,
						texture_offset,
						true);

	vec4 color = sample_texture_with_scroll(
			TEXTURE,
			baseUV,
			texture_scroll_speed,
			TIME);

	if (texture_red_as_alpha)
	{
		color = vec4(texture_color.rgb * color.rgb, color.r);
	}
	else
	{
		color *= texture_color;
	}

	bool apply_contrast = contrast != 1. || brightness != 0.;

	if (apply_contrast)
	{
		if (texture_red_as_alpha)
		{
			color.a = clamp(
				(color.a - 0.5) * contrast + 0.5 + brightness,
				0.,
				1.);
		}
		else
		{
			color.rgb = vec3(
					max(0, (color.r - 0.5) * contrast + 0.5 + brightness),
					max(0, (color.g - 0.5) * contrast + 0.5 + brightness),
					max(0, (color.b - 0.5) * contrast + 0.5 + brightness)
				);
		}
	}

	// ---------------------------------------------- 

	// apply premultiply color
	if (premultiply_color)
	{
		float luminance = get_color_luminance(color);
		color.a = min(luminance, color.a);
	}

	/// apply premultiply alpha
	if (premultiply_alpha)
	{
		color.rgb *= color.a;
	}

	#if defined(OUTLINE)
		if (use_outline)
		{
			color = outline(color, TEXTURE_PIXEL_SIZE, baseUV, TEXTURE);
		}
	#endif

	#if defined(ALPHA_DISOLVE)
		if (use_alpha_disolve)
		{
			color = alpha_disolve(color, color.a, COLOR.a, baseUV, false);
		}
	#endif

	#if defined(ALPHA_MASK)
		if (use_alpha_mask)
		{
			color.a = alpha_mask(color.a, baseUV, true);
		}
	#endif

	// apply color grading if defined
	#if defined(COLOR_GRADING)
		if (use_color_grading)
		{
			color.rgb = color_grading(color);
		}
	#endif

	// apply color ramp if defined
	#if defined(COLOR_RAMP)
		if (use_color_ramp)
		{
			color = color_ramp(color);
		}
	#endif

	#if defined(COLOR_POSTERIZE)
		if (use_color_posterize)
		{
			color.rgb = color_posterize(color.rgb);
		}
	#endif

	#if defined(COLOR_GLOW)
		if (use_color_glow)
		{
			color.rgb = color_glow(color, baseUV, 1.);
		}
	#endif

	#if defined(COLOR_HSV_SHIFT)
		if (use_color_hsv_shift)
		{
			color.rgb = hsv_shift(color.rgb);
		}
	#endif

	#if defined(COLOR_SHADOW)
		if (use_color_shadow)
		{
			color = shadow(color, TEXTURE, baseUV);
		}
	#endif

	#if defined(ALPHA_REMAP)
		if (use_alpha_remap)
		{
			color.a = alpha_remap(color.a);
		}
	#endif

	#if defined(ALPHA_CUTOFF)
		if (use_alpha_cutoff)
		{
			color.a = alpha_cutoff(color.a);
		}
	#endif

	color.a *= texture_alpha;

	// if the following line throws an error thats a godot bug, ignore it.
	// Shader works as intented
	COLOR = color;
}