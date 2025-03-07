vec2 uv_pixelate(vec2 uv, vec2 viewport_size, int uv_pixelate_size)
{
	float aspect_ratio = viewport_size.x / viewport_size.y;
	vec2 pixel_size = vec2(float(uv_pixelate_size), float(uv_pixelate_size) * aspect_ratio);
	uv = floor(uv * pixel_size) / pixel_size;
	return uv;
}