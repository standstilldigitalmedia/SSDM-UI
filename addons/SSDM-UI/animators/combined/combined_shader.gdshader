shader_type canvas_item;

uniform float hue_shift_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float hue_shift_speed : hint_range(0.0, 10.0) = 1.0;

uniform float shimmer_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float shimmer_speed : hint_range(0.0, 20.0) = 2.0;
uniform float shimmer_width : hint_range(0.01, 1.0) = 0.2;
uniform float shimmer_brightness : hint_range(0.0, 2.0) = 0.5;

uniform float dissolve_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float dissolve_mode : hint_range(0.0, 2.0) = 0.0;  // 0=UV_SWEEP, 1=NOISE, 2=RADIAL
uniform float dissolve_progress : hint_range(0.0, 1.0) = 0.0;
uniform float dissolve_spread : hint_range(0.0, 1.0) = 0.1;

uniform float pulse_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float pulse_speed : hint_range(0.0, 20.0) = 2.0;
uniform float pulse_min_alpha : hint_range(0.0, 1.0) = 0.2;

uniform float flicker_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float flicker_speed : hint_range(0.0, 60.0) = 10.0;
uniform float flicker_min : hint_range(0.0, 1.0) = 0.3;

uniform vec4 bg_color : source_color = vec4(1.0);
uniform float color_enabled : hint_range(0.0, 1.0) = 0.0;

vec3 hsv_to_rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 rgb_to_hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float random(vec2 co) {
	return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec4 color = bg_color;

	if (hue_shift_enabled > 0.5 && color.a > 0.01) {
		vec3 hsv = rgb_to_hsv(color.rgb);
		hsv.x = fract(hsv.x + TIME * hue_shift_speed);
		color.rgb = hsv_to_rgb(hsv);
	}

	if (shimmer_enabled > 0.5) {
		float band_pos = fract((UV.x - UV.y + TIME * shimmer_speed) / shimmer_width);
		if (band_pos < shimmer_width) {
			color.rgb += shimmer_brightness * color.a;
		}
	}
	
	if (color_enabled > 0.5) {
		color.rgb = bg_color.rgb;
	}

	if (dissolve_enabled > 0.5) {
		float threshold = 0.0;
		if (dissolve_mode < 0.5) {
			threshold = UV.x;
		} else if (dissolve_mode < 1.5) {
			float t = floor(TIME);
			threshold = random(UV + vec2(t, 0.0));
		} else {
			threshold = length(UV - vec2(0.5, 0.5)) * 2.0;
		}
		float edge = smoothstep(dissolve_progress - dissolve_spread, dissolve_progress, threshold);
		color.a *= 1.0 - edge;
	}

	if (pulse_enabled > 0.5) {
		float pulse_alpha = mix(pulse_min_alpha, 1.0, (sin(TIME * pulse_speed) + 1.0) * 0.5);
		color.a *= pulse_alpha;
	}

	if (flicker_enabled > 0.5) {
		float flicker_alpha = mix(flicker_min, 1.0, random(vec2(floor(TIME * flicker_speed), 0.0)));
		color.a *= flicker_alpha;
	}
	COLOR = color;
}