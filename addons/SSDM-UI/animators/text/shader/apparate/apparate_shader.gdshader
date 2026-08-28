shader_type canvas_item;

uniform float shader_enabled = 0.0;
uniform float apparate_progress = 2.0;
uniform float apparate_spread = 0.15;

void fragment() {
	vec4 color = COLOR;
	vec4 modulate_color = COLOR;
	
	if (shader_enabled > 0.5) {
		float fade_start = apparate_progress - apparate_spread;
		float fade_end = apparate_progress;

		if (UV.x > fade_end) {
			color.a = 0.0;
		} else if (UV.x > fade_start) {
			float fade_factor = (fade_end - UV.x) / apparate_spread;
			color.a *= fade_factor;
		}		
	}
	COLOR = color * modulate_color;
}