shader_type canvas_item;

uniform float glitch_enabled = 0.0;
uniform float glitch_intensity = 0.5;
uniform float glitch_speed = 5.0;
uniform float glitch_block_size = 0.1;
uniform float glitch_color_drift = 0.02;


float random(vec2 st) {
	return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	// Capture incoming modulation (includes font_color, modulate property, etc.)
	vec4 modulate_color = COLOR;
	vec2 uv = UV;

	float glitch_active = 0.0;
	if (glitch_enabled > 0.5) {
		// Intermittent glitch trigger based on time
		float glitch_time = floor(TIME * glitch_speed);
		float glitch_trigger = random(vec2(glitch_time, 1.0));

		// Only glitch some of the time based on intensity
		if (glitch_trigger < glitch_intensity) {
			glitch_active = 1.0;

			// Divide into horizontal blocks and offset each block
			float block = floor(uv.y / glitch_block_size);
			float block_random = random(vec2(block, glitch_time));

			// Offset block horizontally
			uv.x += (block_random - 0.5) * glitch_intensity * 0.15;

			// Occasional vertical jump for extra chaos
			if (random(vec2(glitch_time, block)) > 0.8) {
				uv.y += (random(vec2(block, glitch_time * 2.0)) - 0.5) * glitch_block_size;
			}
		}
	}

	// === 2. Sample Texture ===
	vec4 color;

	if (glitch_active > 0.5) {
		// Sample each color channel at slightly different positions
		float drift = glitch_color_drift * glitch_intensity;
		color.r = texture(TEXTURE, uv + vec2(drift, 0.0)).r;
		color.g = texture(TEXTURE, uv).g;
		color.b = texture(TEXTURE, uv - vec2(drift, 0.0)).b;
		color.a = texture(TEXTURE, uv).a;

		// Occasional color inversion for extra glitchiness
		float glitch_time = floor(TIME * glitch_speed);
		if (random(vec2(glitch_time, 3.0)) > 0.85) {
			color.rgb = vec3(1.0) - color.rgb;
		}
	} else {
		color = texture(TEXTURE, uv);
	}
}
