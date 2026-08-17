shader_type canvas_item;

float random(vec2 st) {
	return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

uniform float shake_enabled = 0.0;
uniform float shake_amount = 0.02;
uniform float shake_speed = 20.0;


void fragment() {
	vec2 uv = UV;
	if (shake_enabled > 0.5) {
		float time_seed = floor(TIME * shake_speed);
		uv.x += (random(vec2(time_seed, 0.0)) - 0.5) * shake_amount;
		uv.y += (random(vec2(0.0, time_seed)) - 0.5) * shake_amount;
	}
}
