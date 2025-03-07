vec3 hsv_shift(vec3 color, float h_shift, float s_shift, float v_shift)
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
	return color.rgb;
}