// helper functions ------------------------------------------
vec2 transform_uv(vec2 uv, vec2 scale, vec2 offset, bool fract_result)
{
	uv = uv * scale + offset;
	if (fract_result)
		uv = fract(uv);
	return uv;
}

vec2 uv_distortion(
	vec2 uv,
	sampler2D distortion_texture,
	vec2 distortion_uv,
	float distortion_amount,
	vec2 distortion_speed,
	bool fract_result)
{
	distortion_uv += mod(TIME * distortion_speed, vec2(1.));
	if (fract_result)
	{
		distortion_uv = fract(distortion_uv);
	}

	float distortAmount =
		(texture(distortion_texture, distortion_uv).r - 0.5) * 0.2 * distortion_amount;
	uv += vec2(1.) * distortAmount;
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

vec2 rotate_vec2(vec2 vector, float angle)
{
	float cosAngle = cos(angle);
	float sinAngle = sin(angle);
	vector = mat2(vec2(cosAngle, -sinAngle), vec2(sinAngle, cosAngle)) * vector;
	return vector;
}

vec2 rotate_uvs(vec2 uv, float rotation, vec2 scale, vec2 offset)
{
	vec2 center = vec2(0.5 * scale.x + offset.x, 0.5 * scale.y + offset.y);
	uv -= center;
	uv = rotate_vec2(uv, rotation);
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

float rand_uncapped(vec2 seed, float offset) {
	return fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453) + offset;
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