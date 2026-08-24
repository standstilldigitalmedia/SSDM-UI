shader_type canvas_item;

uniform float shader_enabled : hint_range(0.0, 1.0) = 0.0;
uniform vec4 bg_color : source_color = vec4(1.0);
uniform float speed : hint_range(0.0, 60.0) = 10.0;
uniform float min_alpha : hint_range(0.0, 1.0) = 0.3;


float random(vec2 co) {
	return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec4 color = bg_color;

	if (shader_enabled > 0.5) {
		float alpha = mix(min_alpha, 1.0, random(vec2(floor(TIME * speed), 0.0)));
		color.a *= alpha;
	}

	COLOR = color;
}
