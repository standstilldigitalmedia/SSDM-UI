shader_type canvas_item;

uniform float shader_enabled : hint_range(0.0, 1.0) = 0.0;
uniform vec4 bg_color : source_color = vec4(1.0);
uniform float speed : hint_range(0.0, 20.0) = 5.0;
uniform float min_alpha : hint_range(0.0, 1.0) = 0.2;


void fragment() {
	vec4 color = bg_color;

	if (shader_enabled > 0.5) {
		float alpha = mix(min_alpha, 1.0, (sin(TIME * speed) + 1.0) * 0.5);
		color.a *= alpha;
	}

	COLOR = color;
}
