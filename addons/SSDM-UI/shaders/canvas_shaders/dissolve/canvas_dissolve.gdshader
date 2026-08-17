shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(1.0);
uniform float dissolve_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float dissolve_mode : hint_range(0.0, 2.0) = 0.0;  // 0=UV_SWEEP, 1=NOISE, 2=RADIAL
uniform float dissolve_progress : hint_range(0.0, 1.0) = 0.0;
uniform float dissolve_spread : hint_range(0.0, 1.0) = 0.1;

float random(vec2 co) {
	return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec4 color = bg_color;

	if (dissolve_enabled > 0.5) {
		float threshold = 0.0;
		if (dissolve_mode < 0.5) {
			// UV_SWEEP: left-to-right
			threshold = UV.x;
		} else if (dissolve_mode < 1.5) {
			// NOISE: pseudo-random threshold per pixel
			float t = floor(TIME);
			threshold = random(UV + vec2(t, 0.0));
		} else {
			// RADIAL: distance from center
			threshold = length(UV - vec2(0.5, 0.5)) * 2.0;
		}
		float edge = smoothstep(dissolve_progress - dissolve_spread, dissolve_progress, threshold);
		color.a *= 1.0 - edge;
		COLOR = color;
	}
}
