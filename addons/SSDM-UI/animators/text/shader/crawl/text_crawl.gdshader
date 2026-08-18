shader_type canvas_item;

// Varying to pass vertex position to fragment shader for crawl fade
varying float vertex_y;

void vertex() {
	// Pass the local Y position to fragment shader for crawl fade calculation
	vertex_y = VERTEX.y;
}


uniform float shader_enabled = 0.0;
uniform float crawl_fade_pixels = 20.0;  // Height of fade zone in pixels
uniform float crawl_label_position_y = 0.0;  // Label's current position.y (updated during scroll)


void fragment() {
	float crawl_fade_factor = 1.0;

	if (shader_enabled > 0.5 && crawl_fade_pixels > 0.0) {
		// vertex_y is the pixel position in label-local space (from vertex shader)
		// Add label's position.y to get position in viewport space
		float viewport_y = vertex_y + crawl_label_position_y;

		// Fade pixels near the top of viewport (viewport_y close to 0)
		if (viewport_y < crawl_fade_pixels) {
			crawl_fade_factor = max(0.0, viewport_y / crawl_fade_pixels);
		}
	}
}
