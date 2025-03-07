// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// THE CODE BELOW IS NOT INTENDED TO BE CHANGED MANUALLY.
// MANUAL CHANGES MIGHT CAUSE THE VFEZ MATERIAL TO WORK INCORRECTLY.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// shader code starts here -----------------------------------------------

#ifndef VFEZ_UTILS
	#include "Effects/vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

#include "Effects/Shared/vfez_uv_distortion.gdshaderinc"

#if defined(UNSHADED)
	render_mode unshaded;
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

#if defined(DEPTH_DRAW_OPAQUE)
	render_mode depth_draw_opaque;
#elif defined(DEPTH_DRAW_ALWAYS)
	render_mode depth_draw_always;
#elif defined(DEPTH_DRAW_NEVER)
	render_mode depth_draw_never;
#endif

#if defined(CULL_BACK)
	render_mode cull_back;
#elif defined(CULL_FRONT)
	render_mode cull_front;
#elif defined (CULL_DISABLED)
	render_mode cull_disabled;
#endif

#if defined(DIFFUSE_LAMBERT)
	render_mode diffuse_lambert;
#elif defined(DIFFUSE_LAMBERT_WRAP)
	render_mode diffuse_lambert_wrap;
#elif defined(DIFFUSE_BURLEY)
	render_mode diffuse_burley;
#elif defined(DIFFUSE_TOON)
	render_mode diffuse_toon;
#endif

#if defined(SPECULAR_SCHLICK_GGX)
	render_mode specular_schlick_ggx;
#elif defined(SPECULAR_TOON)
		render_mode specular_toon;
#elif defined(SPECULAR_DISABLED)
		render_mode specular_disabled;
#endif

#if defined(NO_DEPTH_TEST)
	render_mode depth_test_disabled;
#endif

#if defined(PARTICLE_TRAILS)
	render_mode particle_trails;
#endif

group_uniforms general;
uniform vec3 global_color: source_color = vec3(1.);
uniform float global_alpha: hint_range(0.0, 1.0) = 1.;
uniform bool additive_config = false;
uniform bool premultiply_color = false;
uniform bool premultiply_alpha = false;
group_uniforms;

group_uniforms shape1.shape_texture;
uniform sampler2D shape1_main_texture: source_color, filter_nearest;
uniform vec2 shape1_main_texture_scale = vec2(1.);
uniform vec2 shape1_main_texture_offset = vec2(0.);
uniform vec4 shape1_color: source_color = vec4(1.);
uniform bool shape1_red_as_alpha = false;
uniform vec2 shape1_scroll_speed = vec2(0.);
uniform float shape1_rotation_offset: hint_range(0.0, 6.28318530718) = 0.;
uniform float shape1_rotation_speed = 0.;
group_uniforms;

group_uniforms shape1.contrast_brightness;
uniform float shape1_contrast: hint_range(0.0, 10) = 1.;
uniform float shape1_brightness: hint_range(-1., 1.) = 0.;
group_uniforms;

group_uniforms shape1.distortion;
uniform sampler2D shape1_distortion_texture: source_color;
uniform vec2 shape1_distortion_texture_scale = vec2(1.);
uniform vec2 shape1_distortion_texture_offset = vec2(0.);
uniform float shape1_distortion_amount: hint_range(0.0, 10) = 0.0;
uniform vec2 shape1_distortion_speed = vec2(0.1);
group_uniforms;

group_uniforms shape1.screenspace_uv;
uniform bool shape1_use_screenspace_uv;
group_uniforms;

group_uniforms shape1.polar_uv;
uniform bool shape1_use_polar_uv = false;
uniform vec2 shape1_polar_uv_center = vec2(0.5);
uniform bool shape1_distortion_polar_uvs = false;
group_uniforms;

group_uniforms shape2;
uniform bool use_shape2 = false;
group_uniforms;

#if defined(SHAPE2)
	group_uniforms shape2.shape_texture;
	uniform sampler2D shape2_main_texture: source_color, filter_nearest;
	uniform vec2 shape2_main_texture_scale = vec2(1.);
	uniform vec2 shape2_main_texture_offset = vec2(0.);
	uniform vec4 shape2_color: source_color = vec4(1.);
	uniform bool shape2_red_as_alpha = false;
	uniform vec2 shape2_scroll_speed = vec2(0.);
	uniform float shape2_rotation_offset: hint_range(0.0, 6.28318530718) = 0.;
	uniform float shape2_rotation_speed = 0.;
	group_uniforms;

	group_uniforms shape2.contrast_brightness;
	uniform float shape2_contrast: hint_range(0.0, 10) = 1.;
	uniform float shape2_brightness: hint_range(-1., 1.) = 0.;
	group_uniforms;

	group_uniforms shape2.distortion;
	uniform sampler2D shape2_distortion_texture: source_color;
	uniform vec2 shape2_distortion_texture_scale = vec2(1.);
	uniform vec2 shape2_distortion_texture_offset = vec2(0.);
	uniform float shape2_distortion_amount: hint_range(0.0, 10) = 0.0;
	uniform vec2 shape2_distortion_speed = vec2(0.1);
	group_uniforms;

	group_uniforms shape2.screenspace_uv;
	uniform bool shape2_use_screenspace_uv;
	group_uniforms;

	group_uniforms shape2.polar_uv;
	uniform bool shape2_use_polar_uv = false;
	uniform vec2 shape2_polar_uv_center = vec2(0.5);
	uniform bool shape2_distortion_polar_uvs = false;
	group_uniforms;
#endif

group_uniforms shape3;
uniform bool use_shape3 = false;
group_uniforms;

#if defined(SHAPE3)
	group_uniforms shape3.shape_texture;
	uniform sampler2D shape3_main_texture: source_color, filter_nearest;
	uniform vec2 shape3_main_texture_scale = vec2(1.);
	uniform vec2 shape3_main_texture_offset = vec2(0.);
	uniform vec4 shape3_color: source_color = vec4(1.);
	uniform bool shape3_red_as_alpha = false;
	uniform vec2 shape3_scroll_speed = vec2(0.);
	uniform float shape3_rotation_offset: hint_range(0.0, 6.28318530718) = 0.;
	uniform float shape3_rotation_speed = 0.;
	group_uniforms;

	group_uniforms shape3.contrast_brightness;
	uniform float shape3_contrast: hint_range(0.0, 10) = 1.;
	uniform float shape3_brightness: hint_range(-1., 1.) = 0.;
	group_uniforms;

	group_uniforms shape3.distortion;
	uniform sampler2D shape3_distortion_texture: source_color;
	uniform vec2 shape3_distortion_texture_scale = vec2(1.);
	uniform vec2 shape3_distortion_texture_offset = vec2(0.);
	uniform float shape3_distortion_amount: hint_range(0.0, 10) = 0.0;
	uniform vec2 shape3_distortion_speed = vec2(0.1);
	group_uniforms;

	group_uniforms shape3.screenspace_uv;
	uniform bool shape3_use_screenspace_uv;
	group_uniforms;

	group_uniforms shape3.polar_uv;
	uniform bool shape3_use_polar_uv = false;
	uniform vec2 shape3_polar_uv_center = vec2(0.5);
	uniform bool shape3_distortion_polar_uvs = false;
	group_uniforms;
#endif

group_uniforms combine_shapes;
#if defined(SHAPE2) || defined(SHAPE3)
	uniform bool combine_additive = false;
	uniform float shape1_color_weight: hint_range(0.0, 5.) = 1;
	uniform float shape1_alpha_weight: hint_range(0.0, 5.) = 1;
#endif
#if defined(SHAPE2)
	uniform float shape2_color_weight: hint_range(0.0, 5.) = 1;
	uniform float shape2_alpha_weight: hint_range(0.0, 5.) = 1;
#endif
#if defined(SHAPE3)
	uniform float shape3_color_weight: hint_range(0.0, 5.) = 1;
	uniform float shape3_alpha_weight: hint_range(0.0, 5.) = 1;
#endif
group_uniforms;

group_uniforms color_face_tint;
	uniform bool use_color_face_tint = false;
#if defined(COLOR_FACE_TINT)
	#include "Effects/3D/vfez_color_face_tint.gdshaderinc"
	uniform vec3 backface_tint_color: source_color = vec3(0.5);
	uniform vec3 frontface_tint_color: source_color = vec3(1.);
#endif
group_uniforms;

group_uniforms color_grading;
uniform bool use_color_grading = false;
#if defined(COLOR_GRADING)
	#include "Effects/Shared/vfez_color_grading.gdshaderinc"
	uniform vec3 color_grading_light_tone: source_color;
	uniform vec3 color_grading_mid_tone: source_color;
	uniform vec3 color_grading_dark_tone: source_color;
	uniform float color_grading_mid_point: hint_range(0.0, 1.0) = 0.5;
#endif
group_uniforms;

group_uniforms color_ramp;
uniform bool use_color_ramp = false;
#if defined(COLOR_RAMP)
	#include "Effects/Shared/vfez_color_ramp.gdshaderinc"
	uniform vec4 color_ramp_albedo: source_color = vec4(1.);
	uniform sampler2D color_ramp_texture: source_color, repeat_disable;
	uniform float color_ramp_luminosity: hint_range(-1., 1.) = 0.;
	uniform float color_ramp_blend: hint_range(0.0, 1.0) = 1.;
#endif
group_uniforms;

group_uniforms color_posterize;
uniform bool use_color_posterize = false;
#if defined(COLOR_POSTERIZE)
	#include "Effects/Shared/vfez_color_posterize.gdshaderinc"
	uniform float color_posterize_num_colors: hint_range(0.0, 30.) = 5.;
#endif
group_uniforms;

group_uniforms color_rim;
uniform bool use_color_rim = false;
#if defined(COLOR_RIM)
	#include "Effects/3D/vfez_color_rim.gdshaderinc"
	uniform vec4 rim_color: source_color = vec4(1.);
	uniform float rim_bias: hint_range(0.0, 1.0) = 0.;
	uniform float rim_scale: hint_range(0.0, 25.0) = 1.;
	uniform float rim_power: hint_range(0.1, 20.0) = 5.;
	uniform float rim_intensity: hint_range(0.1, 50.0) = 1.;
	uniform float rim_add_amount: hint_range(0.1, 1.0) = 1.;
	uniform float rim_erodes_alpha: hint_range(0.1, 2.0) = 0.;
#endif
group_uniforms;

group_uniforms color_glow;
uniform bool use_color_glow = false;
#if defined(COLOR_GLOW)
	#include "Effects/Shared/vfez_color_glow.gdshaderinc"
	uniform vec4 glow_color: source_color = vec4(1.);
	uniform float glow_intensity = 0;
	uniform float glow_intensity_global = 1;
	uniform bool use_glow_texture = false;
	uniform sampler2D glow_texture: source_color;
#endif
group_uniforms;

group_uniforms color_hsv_shift;
uniform bool use_color_hsv_shift = false;
#if defined(COLOR_HSV_SHIFT)
	#include "Effects/Shared/vfez_hsv_shift.gdshaderinc"
	uniform float h_shift: hint_range(0.0, 360.0) = 180;
	uniform float s_shift:  hint_range(0.0, 2.) = 1.;
	uniform float v_shift: hint_range(0.0, 2.) = 1.;
#endif
group_uniforms;

group_uniforms alpha_disolve;
uniform bool use_alpha_disolve = false;
#if defined(ALPHA_DISOLVE)
	#include "Effects/Shared/vfez_alpha_disolve.gdshaderinc"
	uniform sampler2D alpha_disolve_texture: source_color;
	uniform vec2 alpha_disolve_texture_scale = vec2(1.);
	uniform vec2 alpha_disolve_texture_offset = vec2(0.);
 	uniform float alpha_disolve_amount: hint_range(-0.1, 1) = -0.1;
	uniform float alpha_disolve_transition: hint_range(0.01, 0.75)= 0.075;
	uniform float alpha_disolve_power: hint_range(0.001, 10) = 1;
	uniform vec2 alpha_disolve_scroll_speed;
	group_uniforms;

	group_uniforms alpha_disolve.disolve_burn;
	uniform bool use_alpha_disolve_burn = false;
	uniform sampler2D alpha_disolve_burn_texture: source_color;
	uniform vec3 alpha_disolve_burn_color: source_color = vec3(1., 1., 0.);
	uniform float alpha_disolve_burn_width: hint_range(0.0, 0.2) = 0.01;
	uniform float alpha_disolve_burn_glow: hint_range(1, 250) = 5;
	group_uniforms;
#else
group_uniforms;
#endif


group_uniforms alpha_mask;
uniform bool use_alpha_mask = false;
#if defined(ALPHA_MASK)
	#include "Effects/Shared/vfez_alpha_mask.gdshaderinc"
	uniform sampler2D alpha_mask_texture: source_color;
	uniform vec2 alpha_mask_scale = vec2(1.);
	uniform vec2 alpha_mask_offset = vec2(0.);
	uniform float alpha_mask_power: hint_range(0.001, 10.) = 1;
#endif
group_uniforms;

group_uniforms alpha_remap;
uniform bool use_alpha_remap = false;
#if defined(ALPHA_REMAP)
	#include "Effects/Shared/vfez_alpha_remap.gdshaderinc"
	uniform float alpha_remap_min: hint_range(0.0, 1.0) = 0;
	uniform float alpha_remap_max: hint_range(0.0, 1.0) = 0.075;
#endif
group_uniforms alpha_remap;

group_uniforms alpha_cutoff;
uniform bool use_alpha_cutoff = false;
#if defined(ALPHA_CUTOFF)
	#include "Effects/Shared/vfez_alpha_cutoff.gdshaderinc"
#endif
group_uniforms;

group_uniforms uv_pixelate;
uniform bool use_uv_pixelate = false;
#if defined(UV_PIXELATE)
	#include "Effects/Shared/vfez_uv_pixelate.gdshaderinc"
	uniform int uv_pixelate_size: hint_range(4, 512) = 32;
#endif
group_uniforms;

group_uniforms uv_twist;
uniform bool use_uv_twist = false;
#if defined(UV_TWIST)
	#include "Effects/Shared/vfez_uv_twist.gdshaderinc"
	uniform float uv_twist_amount: hint_range(0.0, 3.1415) = 1.;
	uniform float uv_twist_pos_x: hint_range(0.0, 1.0) = 0.5;
	uniform float uv_twist_pos_y: hint_range(0.0, 1.0) = 0.5;
	uniform float uv_twist_radius: hint_range(0.0, 3.0) = 0.75;
#endif
group_uniforms;

group_uniforms uv_handrawn;
uniform bool use_uv_handrawn = false;
#if defined(UV_HANDRAWN)
	#include "Effects/Shared/vfez_uv_handrawn.gdshaderinc"
	uniform float uv_handrawn_amount: hint_range(0.0, 40.0) = 10.;
	uniform float uv_handrawn_speed: hint_range(0.0, 30.0) = 5.;
#endif
group_uniforms;

group_uniforms uv_shake;
uniform bool use_uv_shake = false;
#if defined(UV_SHAKE)
	#include "Effects/Shared/vfez_uv_shake.gdshaderinc"
	uniform float uv_shake_speed: hint_range(0.0, 50.0) = 20.;
	uniform float uv_shake_x: hint_range(-15., 15) = 5;
	uniform float uv_shake_y: hint_range(-15., 15) = 4;
#endif
group_uniforms;

group_uniforms uv_wave;
uniform bool use_uv_wave = false;
#if defined(UV_WAVE)
	#include "Effects/Shared/vfez_uv_wave.gdshaderinc"
	uniform float uv_wave_amount: hint_range(0.0, 25.0) = 7.;
	uniform float uv_wave_speed: hint_range(0.0, 25.0) = 10.;
	uniform float uv_wave_strength: hint_range(0.0, 25.0) = 7.5;
	uniform float uv_wave_x: hint_range(0.0, 1.0) = 0.;
	uniform float uv_wave_y: hint_range(0.0, 1.0) = 0.5;
#endif
group_uniforms;

group_uniforms uv_round_wave;
uniform bool use_uv_round_wave = false;
#if defined(UV_ROUND_WAVE)
	#include "Effects/Shared/vfez_uv_round_wave.gdshaderinc"
	uniform float uv_round_wave_strength: hint_range(0.0, 1.0) = 0.7;
	uniform float uv_round_wave_speed: hint_range(0.0, 5.0) = 2.;
#endif
group_uniforms;

group_uniforms uv_global_distortion;
uniform bool use_uv_global_distortion = false;
#if defined(UV_GLOBAL_DISTORTION)
	uniform vec2 uv_global_distortion_texture_scale = vec2(1.);
	uniform vec2 uv_global_distortion_texture_offset = vec2(0.);
	uniform sampler2D uv_global_distortion_texture: source_color;
	uniform vec2 uv_global_distortion_speed;
	uniform float uv_global_distortion_amount: hint_range(0.0, 10.0) = 0.5;
#endif
group_uniforms;

group_uniforms vertex_offset;
uniform bool use_vertex_offset = false;
#if defined(VERTEX_OFFSET)
	#include "Effects/3D/vfez_vertex_offset.gdshaderinc"
	uniform sampler2D vertex_offset_texture: source_color;
	uniform float vertex_offset_amount: hint_range(0.0, 2.) = 0.5;
	uniform float vertex_offset_power: hint_range(0.01, 10.) = 1.;
	uniform vec2 vertex_offset_speed;
#endif
group_uniforms;

group_uniforms vertex_expand;
uniform bool use_vertex_expand;
#if defined(VERTEX_EXPAND)
	#include "Effects/3D/vfez_vertex_expand.gdshaderinc"
	uniform vec3 vertex_expand_center = vec3(0.);
	uniform bool vertex_expand_ignore_center_vertical = false;
	uniform float vertex_expand_amount: hint_range(0.0, 10.) = 0.5;
#endif
group_uniforms;

group_uniforms particle;
uniform bool use_particle_trails = false;
uniform bool use_particle_anim = false;
group_uniforms;

#if defined(PARTICLE_ANIM)
	group_uniforms particle.particle_anim;
	uniform int particles_anim_h_frames : hint_range(1, 128) = 1;
	uniform int particles_anim_v_frames : hint_range(1, 128) = 1;
	uniform bool particles_anim_loop;
	group_uniforms;
#endif


varying vec3 view_direction;
varying vec3 world_normal;
varying vec2 screenspace_uv;

// calculate single shape function ------------------------------

vec4 calculate_shape(
	vec2 baseUV,
	sampler2D shape_main_texture,
	vec2 shape_main_texture_scale,
	vec2 shape_main_texture_offset,
	sampler2D shape_distortion_texture,
	vec2 shape_distortion_texture_scale,
	vec2 shape_distortion_texture_offset,
	float shape_distortion_amount,
	vec2 shape_distortion_speed,
	float shape_rotation_speed,
	float shape_rotation_offset,
	vec2 shape_scroll_speed,
	bool shape_red_as_alpha,
	vec4 shape_color,
	float shape_contrast,
	float shape_brightness,
	bool shape_use_polar_uv,
	vec2 shape_polar_uv_center,
	bool shape_distortion_polar_uvs
	)
{
	vec2 shapeUV = baseUV;

	if (shape_use_polar_uv)
	{
		shapeUV = uv_polar(shapeUV, shape_polar_uv_center);
	}

	shapeUV = transform_uv(
					shapeUV,
					shape_main_texture_scale,
					shape_main_texture_offset,
					false);


	if (shape_distortion_amount > 0.)
	{
		vec2 distort_uvs = baseUV;

		//distort_uvs
		vec2 distortionUV = baseUV;
		distortionUV = transform_uv(
						distortionUV,
						shape_distortion_texture_scale,
						shape_distortion_texture_offset,
						false);

		if (shape_use_polar_uv && shape_distortion_polar_uvs)
		{
			distortionUV = uv_polar(distortionUV, shape_polar_uv_center);
		}

		shapeUV = uv_distortion(shapeUV, shape_distortion_texture, distortionUV,
			shape_distortion_amount, shape_distortion_speed, false);
	}

	shapeUV = rotate_uvs(
		shapeUV,
		shape_rotation_offset + mod(shape_rotation_speed * TIME, TAU),
		shape_main_texture_scale,
		shape_main_texture_offset);


	vec4 shape = sample_texture_with_scroll(
		shape_main_texture,
		shapeUV,
		shape_scroll_speed,
		TIME);

	if (shape_red_as_alpha)
	{
		shape = vec4(shape_color.rgb, shape.r);
	}
	else
	{
		shape *= shape_color;
	}

	bool apply_contrast = shape_contrast != 1. || shape_brightness != 0.;

	if (apply_contrast)
	{
		if (shape_red_as_alpha)
		{
			shape.a = clamp(
				(shape.a - 0.5) * shape_contrast + 0.5 + shape_brightness,
				0.,
				1.);
		}
		else
		{
			shape.rgb = vec3(
					max(0, (shape.r - 0.5) * shape_contrast + 0.5 + shape_brightness),
					max(0, (shape.g - 0.5) * shape_contrast + 0.5 + shape_brightness),
					max(0, (shape.b - 0.5) * shape_contrast + 0.5 + shape_brightness)
				);
		}
	}

	return shape;
}

bool is_using_screen_space_uv()
{
	bool using_shape2_screenspace_uv = false;
	bool using_shape3_screenspace_uv = false;
	#if defined(SHAPE2)
		using_shape2_screenspace_uv = shape2_use_screenspace_uv;
	#endif

	#if defined(SHAPE3)
		using_shape3_screenspace_uv = shape3_use_screenspace_uv;
	#endif

	return shape1_use_screenspace_uv || using_shape2_screenspace_uv || using_shape3_screenspace_uv;
}

// ---------------------------------------------------

void vertex() {

	#if defined(BILLBOARD_ENABLED)
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
				MAIN_CAM_INV_VIEW_MATRIX[0],
				MAIN_CAM_INV_VIEW_MATRIX[1],
				MAIN_CAM_INV_VIEW_MATRIX[2],
				MODEL_MATRIX[3]);
	#elif defined(BILLBOARD_Y)
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
				vec4(normalize(cross(vec3(0.0, 1.0, 0.0), MAIN_CAM_INV_VIEW_MATRIX[2].xyz)), 0.0),
				vec4(0.0, 1.0, 0.0, 0.0),
				vec4(normalize(cross(MAIN_CAM_INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
				MODEL_MATRIX[3]);
	#elif defined(BILLBOARD_PARTICLE)
		mat4 mat_world = mat4(
				normalize(INV_VIEW_MATRIX[0]),
				normalize(INV_VIEW_MATRIX[1]),
				normalize(INV_VIEW_MATRIX[2]),
				MODEL_MATRIX[3]);
		mat_world = mat_world * mat4(
				vec4(cos(INSTANCE_CUSTOM.x), -sin(INSTANCE_CUSTOM.x), 0.0, 0.0),
				vec4(sin(INSTANCE_CUSTOM.x), cos(INSTANCE_CUSTOM.x), 0.0, 0.0),
				vec4(0.0, 0.0, 1.0, 0.0),
				vec4(0.0, 0.0, 0.0, 1.0));
		MODELVIEW_MATRIX = VIEW_MATRIX * mat_world;
	#endif

	#if (defined(BILLBOARD_ENABLED) || defined(BILLBOARD_Y) || defined(BILLBOARD_PARTICLE)) && defined(BILLBOARD_KEEP_SCALE)
		MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(
				vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0),
				vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0),
				vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0),
				vec4(0.0, 0.0, 0.0, 1.0));
		MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
	#endif

	view_direction = normalize((
		INV_VIEW_MATRIX[3] - MODEL_MATRIX * vec4(VERTEX, 1.0)).rgb);

	world_normal = normalize((MODEL_MATRIX * vec4(NORMAL, 1.0)).rgb);

	#if defined(VERTEX_OFFSET)
		if (use_vertex_offset)
		{
			VERTEX = vertex_offset(VERTEX, NORMAL, UV, vertex_offset_texture,
					vertex_offset_amount, vertex_offset_power, vertex_offset_speed);
		}
	#endif

	#if defined(VERTEX_EXPAND)
		if (use_vertex_expand)
		{
			VERTEX = vertex_expand(VERTEX, vertex_expand_center, vertex_expand_ignore_center_vertical, vertex_expand_amount);
		}
	#endif

	#if defined(PARTICLE_ANIM)
		if (use_particle_anim)
		{
			float h_frames = float(particles_anim_h_frames);
			float v_frames = float(particles_anim_v_frames);
			float particle_total_frames = float(particles_anim_h_frames * particles_anim_v_frames);
			float particle_frame = floor(INSTANCE_CUSTOM.z * float(particle_total_frames));
			if (!particles_anim_loop) {
				particle_frame = clamp(particle_frame, 0.0, particle_total_frames - 1.0);
			} else {
				particle_frame = mod(particle_frame, particle_total_frames);
			}
			UV /= vec2(h_frames, v_frames);
			UV += vec2(mod(particle_frame, h_frames) / h_frames, floor((particle_frame + 0.5) / h_frames) / v_frames);
		}
	#endif

	bool using_screen_space_uv = is_using_screen_space_uv();

	// only calculate screenspace uv if used at least by 1 shape
	if (using_screen_space_uv)
	{
		vec4 position_v = MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
		vec4 position_cs = PROJECTION_MATRIX * vec4(position_v.xyz, 1.0);
		vec2 ndc = position_cs.xy / position_cs.w;
		screenspace_uv =  ndc.xy * 0.5 + 0.5;
	}
}

void fragment() {

	// clamp UVS near edges (0., 1., 2., 3., 4., 5.) to reduce folding artifacts
	vec2 uv_floor_top_included = max(vec2(0.), ceil(UV) - vec2(1.));
	vec2 clampedUV = clamp(UV, vec2(0.001) + uv_floor_top_included, vec2(0.999) + uv_floor_top_included);
	vec2 baseUV = clampedUV;

	#if defined(UV_PIXELATE)
		if (use_uv_pixelate)
		{
			baseUV = uv_pixelate(baseUV, VIEWPORT_SIZE, uv_pixelate_size);
		}
	#endif

	#if defined(UV_TWIST)
		if (use_uv_twist)
		{
			baseUV = uv_twist(baseUV, shape1_main_texture_scale, uv_twist_amount,
							uv_twist_pos_x, uv_twist_pos_y, uv_twist_radius);
		}
	#endif

	#if defined(UV_HANDRAWN)
		if (use_uv_handrawn)
		{
			baseUV = uv_handrawn(baseUV, uv_handrawn_amount, uv_handrawn_speed);
		}
	#endif

	#if defined(UV_SHAKE)
		if (use_uv_shake)
		{
			baseUV = uv_shake(baseUV, uv_shake_speed, uv_shake_x, uv_shake_y);
		}
	#endif

	#if defined(UV_WAVE)
		if (use_uv_wave)
		{
			baseUV = uv_wave(baseUV, VIEWPORT_SIZE, shape1_main_texture_scale, uv_wave_amount,
								uv_wave_speed, uv_wave_strength, uv_wave_x, uv_wave_y);
		}
	#endif

	#if defined(UV_ROUND_WAVE)
		if (use_uv_round_wave)
		{
			vec2 main_tex_size = vec2(textureSize(shape1_main_texture, 0));
			baseUV = uv_round_wave(baseUV, main_tex_size, shape1_main_texture_scale,
					uv_round_wave_strength, uv_round_wave_speed);
		}
	#endif

	#if defined(UV_GLOBAL_DISTORTION)
		if (use_uv_global_distortion)
		{
			vec2 global_distortion_uv =
				transform_uv(baseUV,
							uv_global_distortion_texture_scale,
							uv_global_distortion_texture_offset,
							false);
			baseUV = uv_distortion(baseUV, uv_global_distortion_texture, global_distortion_uv,
				uv_global_distortion_amount, uv_global_distortion_speed, false);
		}
	#endif

	vec2 shape1UV;

	if (shape1_use_screenspace_uv)
	{
		shape1UV = screenspace_uv;
	}
	else
	{
		shape1UV = baseUV;
	}

	// calculate shape 1
	vec4 shape1 = calculate_shape(
		shape1UV,
		shape1_main_texture,
		shape1_main_texture_scale,
		shape1_main_texture_offset,
		shape1_distortion_texture,
		shape1_distortion_texture_scale,
		shape1_distortion_texture_offset,
		shape1_distortion_amount,
		shape1_distortion_speed,
		shape1_rotation_speed,
		shape1_rotation_offset,
		shape1_scroll_speed,
		shape1_red_as_alpha,
		shape1_color,
		shape1_contrast,
		shape1_brightness,
		shape1_use_polar_uv,
		shape1_polar_uv_center,
		shape1_distortion_polar_uvs
	);

	// calculate shape2 if defined
	#if defined(SHAPE2)

		vec2 shape2UV;

		if (shape2_use_screenspace_uv)
		{
			shape2UV = screenspace_uv;
		}
		else
		{
			shape2UV = baseUV;
		}

		vec4 shape2 = calculate_shape(
			shape2UV,
			shape2_main_texture,
			shape2_main_texture_scale,
			shape2_main_texture_offset,
			shape2_distortion_texture,
			shape2_distortion_texture_scale,
			shape2_distortion_texture_offset,
			shape2_distortion_amount,
			shape2_distortion_speed,
			shape2_rotation_speed,
			shape2_rotation_offset,
			shape2_scroll_speed,
			shape2_red_as_alpha,
			shape2_color,
			shape2_contrast,
			shape2_brightness,
			shape2_use_polar_uv,
			shape2_polar_uv_center,
			shape2_distortion_polar_uvs
		);
	#endif

	// calculate shape3 if defined
	#if defined(SHAPE3)

		vec2 shape3UV;

		if (shape3_use_screenspace_uv)
		{
			shape3UV = screenspace_uv;
		}
		else
		{
			shape3UV = baseUV;
		}

		vec4 shape3 = calculate_shape(
			shape3UV,
			shape3_main_texture,
			shape3_main_texture_scale,
			shape3_main_texture_offset,
			shape3_distortion_texture,
			shape3_distortion_texture_scale,
			shape3_distortion_texture_offset,
			shape3_distortion_amount,
			shape3_distortion_speed,
			shape3_rotation_speed,
			shape3_rotation_offset,
			shape3_scroll_speed,
			shape3_red_as_alpha,
			shape3_color,
			shape3_contrast,
			shape3_brightness,
			shape3_use_polar_uv,
			shape3_polar_uv_center,
			shape3_distortion_polar_uvs
		);
	#endif

	// ---combine shapes if more than one defined.---
	vec4 color = shape1;

	#if defined(SHAPE2) || defined(SHAPE3)
		if (combine_additive)
		{
			color.rgb = shape1.rgb * shape1_color_weight * shape1.a;
			color.a = shape1.a * shape1_alpha_weight;
		}
		else
		{
			if (shape1_color_weight > 0.)
				color.rgb = shape1.rgb * shape1_color_weight;
			else
				color.rgb = vec3(1.);

			if (shape1_alpha_weight > 0.)
				color.a = shape1.a * shape1_alpha_weight;
			else
				color.a = 1.;
		}
	#endif

	#if defined(SHAPE2)
		if (combine_additive)
		{
			color.rgb += shape2.rgb * shape2_color_weight * shape2.a;
			color.a = max(color.a, shape2.a * shape2_alpha_weight);
		}
		else
		{
			if (shape2_color_weight > 0.)
				color.rgb *= shape2.rgb * shape2_color_weight;

			if (shape2_alpha_weight > 0.)
				color.a *= shape2.a * shape2_alpha_weight;
		}
	#endif

	#if defined(SHAPE3)
		if (combine_additive)
		{
			color.rgb += shape3.rgb * shape3_color_weight * shape3.a;
			color.a = max(color.a, shape3.a * shape3_alpha_weight);
		}
		else
		{
			if (shape3_color_weight > 0.)
				color.rgb *= shape3.rgb * shape3_color_weight;

			if (shape3_alpha_weight > 0.)
				color.a *= shape3.a * shape3_alpha_weight;
		}
	#endif

	color.a = clamp(color.a, 0., 1.);

	// ----------------------------------------------

	// lumincance is used in other effects
	//float luminance = 0.;

	// apply premultiply color
	if (premultiply_color)
	{
		float luminance = get_color_luminance(color);
		//luminance = 0.3 * color.r + 0.59 * color.g + 0.11 * color.b;
		//luminance *= color.a;
		color.a = min(luminance, color.a);
	}

	color.rgb *= global_color * COLOR.rgb;

	/// apply premultiply alpha
	if (premultiply_alpha)
	{
		color.rgb *= color.a;
	}

	#if defined(ALPHA_DISOLVE)
		if (use_alpha_disolve)
		{
			float luminance = get_color_luminance(color);
			float pre_disolve_alpha = color.a;
			if (additive_config && !premultiply_color)
			{
				pre_disolve_alpha *= luminance;
			}

			vec2 disolve_uv = transform_uv(baseUV, alpha_disolve_texture_scale, alpha_disolve_texture_offset, false);

			color = alpha_disolve(color, pre_disolve_alpha, COLOR.a, alpha_disolve_texture, disolve_uv,
						alpha_disolve_amount, alpha_disolve_transition, alpha_disolve_power,
						alpha_disolve_scroll_speed, use_alpha_disolve_burn, alpha_disolve_burn_texture, alpha_disolve_burn_color,
						alpha_disolve_burn_width, alpha_disolve_burn_glow);
		}
	#endif

	#if defined(COLOR_FACE_TINT)
		if (use_color_face_tint)
		{
			color.rgb = color_face_tint(color.rgb, backface_tint_color,
					frontface_tint_color, world_normal, view_direction);
		}
	#endif

	// apply color grading if defined
	#if defined(COLOR_GRADING)
		if (use_color_grading)
		{
			color.rgb = color_grading(color, color_grading_light_tone,
				color_grading_mid_tone, color_grading_dark_tone, color_grading_mid_point);
		}
	#endif

	// apply color ramp if defined
	#if defined(COLOR_RAMP)
		if (use_color_ramp)
		{
			color = color_ramp(color, color_ramp_albedo,
					color_ramp_texture, color_ramp_luminosity, color_ramp_blend);
		}
	#endif

	#if defined(COLOR_POSTERIZE)
		if (use_color_posterize)
		{
			color.rgb = color_posterize(color.rgb, color_posterize_num_colors);
		}
	#endif

	#if defined(COLOR_RIM)
		if (use_color_rim)
		{
			color = color_rim(color, NORMAL, VIEW, rim_color,
					rim_bias, rim_scale, rim_power, rim_intensity,
					rim_add_amount, rim_erodes_alpha);
		}
	#endif

	#if defined(COLOR_GLOW)
		if (use_color_glow)
		{
			float glow_mult = 1.;
			if (additive_config)
			{
				float luminance = get_color_luminance(color);
				glow_mult = luminance;
			}

			color.rgb = color_glow(color, glow_texture, use_glow_texture,
					baseUV, glow_color.rgb, glow_mult, glow_intensity, glow_intensity_global);
		}
	#endif

	#if defined(COLOR_HSV_SHIFT)
		if (use_color_hsv_shift)
		{
			color.rgb = hsv_shift(color.rgb, h_shift, s_shift, v_shift);
		}
	#endif

	#if defined(ALPHA_MASK)
		if (use_alpha_mask)
		{
			vec2 alpha_mask_uv = transform_uv(clampedUV, alpha_mask_scale, alpha_mask_offset, false);
			color.a = alpha_mask(color.a, alpha_mask_texture, alpha_mask_uv, alpha_mask_power);
		}
	#endif

	#if defined(ALPHA_REMAP)
		if (use_alpha_remap)
		{
			color.a = alpha_remap(color.a, alpha_remap_min, alpha_remap_max);
		}
	#endif

	#if defined(ALPHA_CUTOFF)
		if (use_alpha_cutoff)
		{
			color.a = alpha_cutoff(color.a);
		}
	#endif

	color.a = color.a * global_alpha * COLOR.a;

	if (additive_config)
	{{
		color.rgb *= color.a;
	}}

	ALBEDO = color.rgb;
	ALPHA = color.a;
}