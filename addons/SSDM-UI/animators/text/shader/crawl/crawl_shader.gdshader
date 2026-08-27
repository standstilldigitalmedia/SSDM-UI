shader_type canvas_item;

varying float vertex_y;
uniform float shader_enabled = 0.0;
uniform float fade_pixels = 20.0;  // Height of fade zone in pixels
uniform float label_position_y = 0.0;  // Label's current position.y (updated during scroll)

void vertex() {
	// Pass the local Y position to fragment shader for crawl fade calculation
	vertex_y = VERTEX.y;
}

void fragment() {
	float fade_factor = 1.0;
	vec4 color;
	vec4 modulate_color = COLOR;
	vec2 uv = UV;
	
	color = texture(TEXTURE, uv);

	if (shader_enabled > 0.5 && fade_pixels > 0.0) {
		// vertex_y is the pixel position in label-local space (from vertex shader)
		// Add label's position.y to get position in viewport space
		float viewport_y = vertex_y + label_position_y;

		// Fade pixels near the top of viewport (viewport_y close to 0)
		if (viewport_y < fade_pixels) {
			fade_factor = max(0.0, viewport_y / fade_pixels);
		}
		color.a *= fade_factor;
		COLOR = color * modulate_color;
	}
}