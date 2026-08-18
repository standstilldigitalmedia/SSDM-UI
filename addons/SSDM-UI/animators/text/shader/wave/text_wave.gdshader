shader_type canvas_item;


uniform float shader_enabled = 0.0;
uniform float wave_amplitude = 0.03;
uniform float wave_frequency = 10.0;
uniform float wave_speed = 3.0;
uniform float wave_horizontal = 0.0;  // 0 = vertical wave (up/down), 1 = horizontal wave (left/right)


void fragment() {
	vec2 uv = UV;

	if (shader_enabled > 0.5) {
		if (wave_horizontal > 0.5) {
			// Horizontal wave: text moves left/right based on Y position
			uv.x += sin(uv.y * wave_frequency + TIME * wave_speed) * wave_amplitude;
		} else {
			// Vertical wave: text moves up/down based on X position
			uv.y += sin(uv.x * wave_frequency + TIME * wave_speed) * wave_amplitude;
		}
	}
}
