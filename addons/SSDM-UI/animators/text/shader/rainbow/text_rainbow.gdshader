shader_type canvas_item;


uniform float shader_enabled = 0.0;
uniform float rainbow_frequency = 1.0;
uniform float rainbow_speed = 1.0;
uniform float rainbow_saturation = 1.0;


vec3 hsv_to_rgb(vec3 hsv) {
	float h = hsv.x * 6.0;
	float s = hsv.y;
	float v = hsv.z;

	float c = v * s;
	float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
	float m = v - c;

	vec3 rgb;
	if (h < 1.0) rgb = vec3(c, x, 0.0);
	else if (h < 2.0) rgb = vec3(x, c, 0.0);
	else if (h < 3.0) rgb = vec3(0.0, c, x);
	else if (h < 4.0) rgb = vec3(0.0, x, c);
	else if (h < 5.0) rgb = vec3(x, 0.0, c);
	else rgb = vec3(c, 0.0, x);

	return rgb + vec3(m);
}

// Pseudo-random function
float random(vec2 st) {
	return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec4 color;
	vec4 modulate_color = COLOR;

	if (shader_enabled > 0.5) {
		float hue = fract(UV.x * rainbow_frequency + TIME * rainbow_speed);
		vec3 rainbow_color = hsv_to_rgb(vec3(hue, rainbow_saturation, 1.0));
		// Multiply to preserve text shape (only colored pixels get rainbow)
		color.rgb *= rainbow_color;
		COLOR = vec4(color.rgb, color.a * modulate_color.a);
	} else {
		COLOR = color * modulate_color;
	}
}
