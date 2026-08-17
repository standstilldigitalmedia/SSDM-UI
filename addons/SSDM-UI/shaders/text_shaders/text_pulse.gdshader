shader_type canvas_item;

uniform float pulse_enabled = 0.0;
uniform float pulse_speed = 2.0;
uniform float pulse_min_alpha = 0.3;


void fragment() {
	vec4 color;
	if (pulse_enabled > 0.5) {
		float pulse = mix(pulse_min_alpha, 1.0, (sin(TIME * pulse_speed) + 1.0) * 0.5);
		color.a *= pulse;
	}
}
