#ifndef VFEZ_UTILS
	#include "vfez_utils.gdshaderinc"
	#define VFEZ_UTILS
#endif

group_uniforms glitch;
uniform float glitch_amount: hint_range(0.0, 20.) = 3.;
uniform float glitch_size: hint_range(0.25, 5.) = 1.;
group_uniforms;

vec3 glitch(vec3 color, vec2 uv, sampler2D main_texture)
{
	vec2 glitch_uv = uv - 0.5;
	float line_noise =
		pow(rand(floor(glitch_uv * vec2(24., 19.) * glitch_size) * 4.0, TIME), 3.0) * glitch_amount
		* pow(rand(floor(glitch_uv * vec2(38., 14.) * glitch_size) * 4.0, TIME), 3.0);

	color = texture(main_texture, uv + vec2(line_noise * 0.02 * rand(vec2(2.0, 1.), TIME), 0)).rgb;
	return color;
}