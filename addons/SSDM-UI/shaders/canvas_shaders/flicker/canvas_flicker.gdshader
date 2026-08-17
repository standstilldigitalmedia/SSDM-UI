shader_type canvas_item;

uniform float flicker_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float flicker_speed : hint_range(0.0, 60.0) = 10.0;
uniform float flicker_min : hint_range(0.0, 1.0) = 0.3;


float random(vec2 co) {
	return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	if (flicker_enabled > 0.5) {
		float flicker_alpha = mix(flicker_min, 1.0, random(vec2(floor(TIME * flicker_speed), 0.0)));
		color.a *= flicker_alpha;
	}

	COLOR = color;
}
