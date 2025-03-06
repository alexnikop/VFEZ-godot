// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// THE CODE BELOW IS NOT INTENDED TO BE CHANGED MANUALLY.
// MANUAL CHANGES MIGHT CAUSE THE VFEZ MATERIAL TO WORK INCORRECTLY.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// shader code starts here -----------------------------------------------

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
uniform bool replicate_texture_on_scale = true;
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

#if defined(OUTLINE)
	uniform vec3 outline_color: source_color;
	uniform float outline_alpha: hint_range(0.0, 1.0) = 1.0;
	uniform float outline_glow;
	uniform float outline_width;
	uniform bool only_render_outline;
#endif
group_uniforms;

#if defined(OUTLINE)
	group_uniforms outline.pixel_perfect;
	uniform bool use_pixel_perfect_outline;
	uniform int outline_pixel_width;
	group_uniforms;
#endif

#if defined(OUTLINE)
	group_uniforms outline.texture;
	uniform bool use_outline_texture;
	uniform sampler2D outline_texture;
	uniform vec2 outline_texture_scale = vec2(1.);
	uniform vec2 outline_texture_offset = vec2(0.);
	uniform vec2 outline_texture_scroll_speed = vec2(0.);
	group_uniforms;
#endif

#if defined(OUTLINE)
	group_uniforms outline.distortion;
	uniform bool use_outline_distortion;
	uniform sampler2D outline_distortion_texture;
	uniform vec2 outline_distortion_texture_scale = vec2(1.);
	uniform vec2 outline_distortion_texture_offset = vec2(0.);
	uniform vec2 outline_distortion_texture_scroll_speed = vec2(0.);
	uniform float outline_distortion_amount;
	group_uniforms;
#endif

group_uniforms rect_size;
uniform float rect_size_ratio: hint_range(1.0, 5.0) = 1.0;
group_uniforms;

group_uniforms color_grading;
uniform bool use_color_grading = false;
#if defined(COLOR_GRADING)
	uniform vec3 color_grading_light_tone: source_color;
	uniform vec3 color_grading_mid_tone: source_color;
	uniform vec3 color_grading_dark_tone: source_color;
	uniform float color_grading_mid_point: hint_range(0.0, 1.0) = 0.5;
#endif
group_uniforms;

group_uniforms color_ramp;
uniform bool use_color_ramp = false;
#if defined(COLOR_RAMP)
	uniform vec4 color_ramp_albedo: source_color = vec4(1.);
	uniform sampler2D color_ramp_texture: source_color, repeat_disable;
	uniform float color_ramp_luminosity: hint_range(-1., 1.) = 0.;
	uniform float color_ramp_blend: hint_range(0.0, 1.0) = 1.;
#endif
group_uniforms;

group_uniforms color_posterize;
uniform bool use_color_posterize = false;
#if defined(COLOR_POSTERIZE)
	uniform float color_posterize_num_colors: hint_range(0.0, 30.) = 5.;
#endif
group_uniforms;

group_uniforms color_glow;
uniform bool use_color_glow = false;
#if defined(COLOR_GLOW)
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
	uniform float h_shift: hint_range(0.0, 360.0) = 180;
	uniform float s_shift:  hint_range(0.0, 2.) = 1.;
	uniform float v_shift: hint_range(0.0, 2.) = 1.;
#endif
group_uniforms;

group_uniforms color_shadow;
uniform bool use_color_shadow = false;
#if defined(COLOR_SHADOW)
	uniform float color_shadow_x: hint_range(-0.5, 0.5) = 0.1;
	uniform float color_shadow_y: hint_range(-0.5, 0.5) = 0.1;
	uniform float color_shadow_alpha: hint_range(0., 1.) = 0.5;
	uniform vec3 color_shadow_color: source_color = vec3(0.);
#endif
group_uniforms;

group_uniforms alpha_disolve;
uniform bool use_alpha_disolve = false;
#if defined(ALPHA_DISOLVE)
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
	uniform sampler2D alpha_mask_texture: source_color;
	uniform vec2 alpha_mask_scale = vec2(1.);
	uniform vec2 alpha_mask_offset = vec2(0.);
	uniform float alpha_mask_power: hint_range(0.001, 10.) = 1;
#endif
group_uniforms;

group_uniforms alpha_remap;
uniform bool use_alpha_remap = false;
#if defined(ALPHA_REMAP)
	uniform float alpha_remap_min: hint_range(0.0, 1.0) = 0;
	uniform float alpha_remap_max: hint_range(0.0, 1.0) = 0.075;
#endif
group_uniforms alpha_remap;

group_uniforms alpha_cutoff;
uniform bool use_alpha_cutoff = false;
#if defined(ALPHA_CUTOFF)
	uniform float alpha_cuttof_value: hint_range(0.001, 1.) = 0.5;
#endif
group_uniforms;

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
#if defined(UV_PIXELATE)
	uniform int uv_pixelate_size: hint_range(4, 512) = 32;
#endif
group_uniforms;

group_uniforms uv_twist;
uniform bool use_uv_twist = false;
#if defined(UV_TWIST)
	uniform float uv_twist_amount: hint_range(0.0, 3.1415) = 1.;
	uniform float uv_twist_pos_x: hint_range(0.0, 1.0) = 0.5;
	uniform float uv_twist_pos_y: hint_range(0.0, 1.0) = 0.5;
	uniform float uv_twist_radius: hint_range(0.0, 3.0) = 0.75;
#endif
group_uniforms;

group_uniforms uv_handrawn;
uniform bool use_uv_handrawn = false;
#if defined(UV_HANDRAWN)
	uniform float uv_handrawn_amount: hint_range(0.0, 40.0) = 10.;
	uniform float uv_handrawn_speed: hint_range(0.0, 30.0) = 5.;
#endif
group_uniforms;

group_uniforms uv_shake;
uniform bool use_uv_shake = false;
#if defined(UV_SHAKE)
	uniform float uv_shake_speed: hint_range(0.0, 50.0) = 20.;
	uniform float uv_shake_x: hint_range(-15., 15) = 5;
	uniform float uv_shake_y: hint_range(-15., 15) = 4;
#endif
group_uniforms;

group_uniforms uv_wave;
uniform bool use_uv_wave = false;
#if defined(UV_WAVE)
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
	uniform float uv_round_wave_strength: hint_range(0.0, 1.0) = 0.7;
	uniform float uv_round_wave_speed: hint_range(0.0, 5.0) = 2.;
#endif
group_uniforms;

group_uniforms particle_anim;
uniform bool use_particle_anim = false;
#if defined(PARTICLE_ANIM)
	uniform int particles_anim_h_frames : hint_range(1, 128) = 1;
	uniform int particles_anim_v_frames : hint_range(1, 128) = 1;
	uniform bool particles_anim_loop;
#endif
group_uniforms;

// helper functions ------------------------------------------
vec2 transform_uv(vec2 uv, vec2 scale, vec2 offset)
{
	uv = uv * scale + offset;
	if (replicate_texture_on_scale)
		uv = fract(uv);
	return uv;

}

vec2 uv_polar(vec2 uv, vec2 center)
{
	vec2 dir = uv - center;
	float radius = length(dir) * 2.;
	float angle = atan(dir.y, dir.x) / (2. * PI);
	vec2 polarUV = vec2(angle, radius);
	//baseUV = mod(vec2(radius, angle), 1.0);
	return polarUV;
}

vec2 rotate_uvs(vec2 uv, float rotation, vec2 scale, vec2 offset)
{
	vec2 center = vec2(0.5 * scale.x + offset.x, 0.5 * scale.y + offset.y);
	float cosAngle = cos(rotation);
	float sinAngle = sin(rotation);
	uv -= center;
	uv = mat2(vec2(cosAngle, -sinAngle), vec2(sinAngle, cosAngle)) *  uv;
	uv += center;
	return uv;
}

vec4 sample_texture_with_scroll(sampler2D tex, vec2 uv, vec2 scroll_speed, float time)
{
	uv.x += mod(time * scroll_speed.x, 1);
	uv.y += mod(time * scroll_speed.y, 1);
	if (scroll_speed != vec2(0.))
		uv = fract(uv);
	return texture(tex, uv);
}

float rand(vec2 seed, float offset) {
	return mod(fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453) + offset, 1.0);
}

float rand2(vec2 seed, float offset, float time) {
	return mod(
			fract(
				sin(
					dot(seed * floor(50. + mod(time, 1.0) * 12.), vec2(127.1, 311.7))
				) * 43758.5453123
			) + offset, 1.0);
}

float remap_float(float inValue, float inMin, float inMax, float outMin, float outMax){
	return outMin + (inValue - inMin) * (outMax - outMin) / (inMax - inMin);
}

float ease_out_quint(float x) {
	return 1. - pow(1. - x, 5.);
}

float get_color_luminance(vec4 color)
{
	float luminance = 0.3 * color.r + 0.59 * color.g + 0.11 * color.b;
	luminance *= color.a;
	return luminance;
}

// helper functions end -----------------------------------------

void vertex() {
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

	VERTEX += VERTEX * (rect_size_ratio - 1.0);
}

void fragment() {
	vec2 baseUV = UV;

	baseUV = baseUV * rect_size_ratio + vec2(-rect_size_ratio * 0.5 + 0.5);

	if (!apply_scale_offset_after_uv_effects)
		baseUV = transform_uv(
						baseUV,
						texture_scale,
						texture_offset);

	#if defined(UV_PIXELATE)
		if (use_uv_pixelate)
		{
			vec2 texture_size = 1. / TEXTURE_PIXEL_SIZE;
			float aspect_ratio = texture_size.x / texture_size.y;
			vec2 pixel_size = vec2(float(uv_pixelate_size), float(uv_pixelate_size) * aspect_ratio);
			baseUV = floor(baseUV * pixel_size) / pixel_size;
		}
	#endif

	#if defined(UV_TWIST)
		if (use_uv_twist)
		{
			vec2 twistUV = baseUV - vec2(uv_twist_pos_x * texture_scale.x,
										uv_twist_pos_y * texture_scale.y);
			float twist_radius = uv_twist_radius *
					(texture_scale.x + texture_scale.y) / 2.;
			float percent = (twist_radius - length(twistUV)) / twist_radius;
			float theta = percent * percent * (2.0 * sin(uv_twist_amount)) * 8.0;
			float s = sin(theta);
			float c = cos(theta);
			float beta = max(sign(twist_radius - length(twistUV)), 0.);
			twistUV = vec2(dot(twistUV, vec2(c, -s)), dot(twistUV, vec2(s, c))) * beta + twistUV * (1. - beta);
			twistUV += vec2(uv_twist_pos_x * texture_scale.x,
							uv_twist_pos_y * texture_scale.y);
			baseUV = twistUV;
		}
	#endif

	#if defined(UV_HANDRAWN)
		if (use_uv_handrawn)
		{
			vec2 handrawnUV = baseUV;
			float handrawn_speed =
				floor(TIME * 20. * uv_handrawn_speed);
			handrawnUV.x = sin((handrawnUV.x * uv_handrawn_amount + handrawn_speed / 2.) * 4.);
			handrawnUV.y = sin((handrawnUV.y * uv_handrawn_amount + handrawn_speed / 2.) * 4.);
			baseUV = mix(baseUV, baseUV + handrawnUV, 0.0005 * uv_handrawn_amount);
		}
	#endif

	#if defined(UV_SHAKE)
		if (use_uv_shake)
		{
			float x_shake = sin(TIME * uv_shake_speed * 50.) * uv_shake_x;
			float y_shake = cos(TIME * uv_shake_speed * 50.) * uv_shake_y;
			baseUV += vec2(x_shake * 0.012, y_shake * 0.01);
		}
	#endif

	#if defined(UV_WAVE)
		if (use_uv_wave)
		{
			vec2 texture_size = 1. / TEXTURE_PIXEL_SIZE;
			vec2 waveUV = vec2(uv_wave_x * texture_scale.x,
							uv_wave_y * texture_scale.y) - baseUV;
			waveUV.x *= texture_size.x / texture_size.y;
			float ang_wave =
				(sqrt(dot(waveUV, waveUV)) * uv_wave_amount)
				- mod(TIME * uv_wave_speed, 360.0);
			baseUV = baseUV + normalize(waveUV) * sin(ang_wave) * (uv_wave_strength / 1000.);
		}
	#endif

	#if defined(UV_ROUND_WAVE)
		if (use_uv_round_wave)
		{
			vec2 main_tex_size = vec2(textureSize(TEXTURE, 0));
			float round_wave_x = 0.5 * texture_scale.x - baseUV.x;
			float round_wave_y = (0.5 * texture_scale.y - baseUV.y) *
				 main_tex_size.y / main_tex_size.x;
			float ripple = -sqrt(round_wave_x * round_wave_x + round_wave_y * round_wave_y);
			baseUV += mod(sin((ripple + TIME * (uv_round_wave_speed/10.0)) / 0.015)
				* (uv_round_wave_strength /10.0), 1.0);
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
							distortion_tex_offset);

			#if defined(UV_POLAR)
				if (use_uv_polar && distortion_uses_uv_polar)
				{
					distortionUV = uv_polar(distortionUV, uv_polar_center);
				}
			#endif

			distortionUV += mod(TIME * distortion_speed, vec2(1.));
			distortionUV = fract(distortionUV);

			float distortAmount =
				(texture(distortion_tex, distortionUV).r - 0.5) * 0.2 * distortion_amount;
			baseUV += vec2(1.) * distortAmount;
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
						texture_offset);

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

			float disolve_amount = clamp(alpha_disolve_amount + (1. - COLOR.a), 0., 1.);
			float disolve_transition = max(0.01, alpha_disolve_transition * ease_out_quint(disolve_amount));
			vec2 disolve_uv = baseUV;
			disolve_uv = transform_uv(disolve_uv, alpha_disolve_texture_scale, alpha_disolve_texture_offset);
			disolve_uv += mod(TIME * alpha_disolve_scroll_speed, 1.0);
			disolve_amount = clamp(pow(disolve_amount, alpha_disolve_power), 0., 1.);
			float disolve_sample = texture(alpha_disolve_texture, disolve_uv).r;
			float disolve = clamp(
				smoothstep(
						0.0,
						disolve_transition,
						remap_float(1.0 - disolve_amount, 0.0, 1.0, -1.0, 1.0) + disolve_sample
				), 0., 1.);

			color.a *= disolve;

			if (use_alpha_disolve_burn)
			{
				float disolve_burn = clamp(
						smoothstep(
							0.,
							disolve_transition + alpha_disolve_burn_width,
							remap_float(1.0 - disolve_amount, 0.0, 1.0, -1.0, 1.0) + disolve_sample
						), 0., 1.
					);

				disolve_burn = disolve - disolve_burn;
				vec3 disolve_burn_color = alpha_disolve_burn_color.rgb * alpha_disolve_burn_glow;

				color.rgb += disolve_burn *
						texture(alpha_disolve_burn_texture, disolve_uv).rgb
						* disolve_burn_color.rgb
						* pre_disolve_alpha;
			}
		}
	#endif

	// apply color grading if defined
	#if defined(COLOR_GRADING)
		if (use_color_grading)
		{
			float luminance = get_color_luminance(color);
			vec3 color_grading_dark_middle_mix = mix(
				color_grading_dark_tone,
				color_grading_mid_tone,
				luminance / color_grading_mid_point
			);

			vec3 color_grading_middle_light_mix = mix(
				color_grading_mid_tone,
				color_grading_light_tone,
				(luminance - color_grading_mid_point) / (1.0 - color_grading_mid_point)
			);

			color.rgb *= mix(
				color_grading_dark_middle_mix,
				color_grading_middle_light_mix,
				step(color_grading_mid_point, luminance)
			);
		}
	#endif

	// apply color ramp if defined
	#if defined(COLOR_RAMP)
		if (use_color_ramp)
		{
			float luminance = get_color_luminance(color);
			float color_ramp_luminance = clamp(luminance + color_ramp_luminosity, 0., 1.);
			vec4 color_ramp_res = texture(color_ramp_texture, vec2(color_ramp_luminance)) * color_ramp_albedo;
			color.rgb = mix(color.rgb, color_ramp_res.rgb, color_ramp_blend);
			color.a = mix(color.a, clamp(color.a * color_ramp_res.a, 0., 1.), color_ramp_blend);
		}
	#endif

	#if defined(COLOR_POSTERIZE)
		if (use_color_posterize)
		{
			color.rgb = floor(color.rgb / (1.0 / color_posterize_num_colors)) * (1.0 / color_posterize_num_colors);
		}
	#endif

	#if defined(COLOR_GLOW)
		if (use_color_glow)
		{
			float glow_mask = 1.;

			if (use_glow_texture)
			{
				glow_mask = texture(glow_texture, baseUV).r;
			}

			float glow_mult = 1.;
			color.rgb *= glow_intensity_global * glow_mask;
			color.rgb += glow_color.rgb * glow_intensity * glow_mask * color.a * glow_mult;
		}
	#endif

	#if defined(COLOR_HSV_SHIFT)
		if (use_color_hsv_shift)
		{
			vec3 result_hsv = vec3(color.rgb);
			float cos_hsv = v_shift * s_shift * cos(h_shift * PI / 180.);
			float sin_hsv = v_shift * s_shift * sin(h_shift * PI / 180.);
			result_hsv.x = (.299 * v_shift + .701 * cos_hsv + .168 * sin_hsv) * color.x
				+ (.587 * v_shift - .587 * cos_hsv + .330 * sin_hsv) * color.y
				+ (.114 * v_shift - .114 * cos_hsv - .497 * sin_hsv) * color.z;
			result_hsv.y = (.299 * v_shift - .299 * cos_hsv - .328 * sin_hsv) *color.x
				+ (.587 * v_shift + .413 * cos_hsv + .035 * sin_hsv) * color.y
				+ (.114 * v_shift - .114 * cos_hsv + .292 * sin_hsv) * color.z;
			result_hsv.z = (.299 * v_shift - .3 * cos_hsv + 1.25 * sin_hsv) * color.x
				+ (.587 * v_shift - .588 * cos_hsv - 1.05 * sin_hsv) * color.y
				+ (.114 * v_shift + .886 * cos_hsv - .203 * sin_hsv) * color.z;
			color.rgb = result_hsv;
		}
	#endif

	#if defined(COLOR_SHADOW)
		if (use_color_shadow)
		{
			vec2 shadowOffset = vec2(color_shadow_x, color_shadow_y);
			float shadowA = texture(TEXTURE, baseUV + shadowOffset).a;
			color.rgb *= 1. - (shadowA - color.a) * (1. - color.a);
			color.rgb += color_shadow_color * shadowA * (1. - color.a);
			color = clamp(color, 0., 1.);
			color.a = max(shadowA * color_shadow_alpha, color.a);
		}
	#endif

	#if defined(OUTLINE)
		if (use_outline)
		{
			vec2 destUV;
			if (use_pixel_perfect_outline)
			{
				destUV = TEXTURE_PIXEL_SIZE * float(outline_pixel_width);
			}
			else
			{
				destUV = TEXTURE_PIXEL_SIZE * float(outline_width) * 200.;
			}

			if (use_outline_distortion)
			{
				vec2 outlineDistUV = transform_uv(
					baseUV,
					outline_distortion_texture_scale,
					outline_distortion_texture_offset);

				outlineDistUV += mod(TIME * outline_distortion_texture_scroll_speed,vec2(1.));
				outlineDistUV = fract(outlineDistUV);

				float outlineDistAmount =
					(texture(outline_distortion_texture, outlineDistUV).r - 0.5) * 0.2 * outline_distortion_amount;
				destUV += vec2(outlineDistAmount);
			}

			float left = texture(TEXTURE, baseUV + vec2(destUV.x, 0.)).a;
			float right = texture(TEXTURE, baseUV - vec2(destUV.x, 0.)).a;
			float bottom = texture(TEXTURE, baseUV + vec2(0., destUV.y)).a;
			float top = texture(TEXTURE, baseUV - vec2(0., destUV.y)).a;
			float result = left + right + bottom + top;

			result = step(0.05, clamp(result, 0., 1.));

			vec4 final_outline_color = vec4(outline_color, 1.0);

			if (use_outline_texture)
			{
				vec2 outlineTexUV = transform_uv(
					baseUV,
					outline_texture_scale,
					outline_texture_offset);

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

		}
	#endif

	#if defined(ALPHA_MASK)
		if (use_alpha_mask)
		{
			vec2 alphaMaskUV = baseUV;
			alphaMaskUV = transform_uv(alphaMaskUV, alpha_mask_scale, alpha_mask_offset);
			vec4 alpha_mask_sample = texture(alpha_mask_texture, alphaMaskUV);
			float mask = pow(min(alpha_mask_sample.r, alpha_mask_sample.a), alpha_mask_power);
			color.a *= mask;
		}
	#endif

	#if defined(ALPHA_REMAP)
		if (use_alpha_remap)
		{
			color.a = smoothstep(alpha_remap_min, alpha_remap_max, color.a);
		}
	#endif

	#if defined(ALPHA_CUTOFF)
		if (use_alpha_cutoff)
		{
			if (((1. - alpha_cuttof_value) - (1. - color.a) - 0.01) < 0.)
			{
				color.a = 0.;
			}
		}
	#endif

	color.a *= texture_alpha;
	COLOR = color;
}