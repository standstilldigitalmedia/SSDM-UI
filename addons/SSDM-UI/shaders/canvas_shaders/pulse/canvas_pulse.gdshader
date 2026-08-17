shader_type canvas_item;

uniform float pulse_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float pulse_speed : hint_range(0.0, 20.0) = 2.0;
uniform float pulse_min_alpha : hint_range(0.0, 1.0) = 0.2;


void fragment() {
	vec4 color = texture(TEXTURE, UV);

	if (pulse_enabled > 0.5) {
		float pulse_alpha = mix(pulse_min_alpha, 1.0, (sin(TIME * pulse_speed) + 1.0) * 0.5);
		color.a *= pulse_alpha;
	}

	COLOR = color;
}
