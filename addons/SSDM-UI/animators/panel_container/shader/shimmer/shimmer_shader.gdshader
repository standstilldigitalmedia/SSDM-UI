shader_type canvas_item;

uniform float shader_enabled : hint_range(0.0, 1.0) = 0.0;
uniform vec4 bg_color : source_color = vec4(1.0);
uniform float speed : hint_range(0.0, 20.0) = 2.0;
uniform float width : hint_range(0.01, 1.0) = 0.2;
uniform float brightness : hint_range(0.0, 2.0) = 0.5;


void fragment() {
	vec4 color = bg_color;

	if (shader_enabled > 0.5) {
		float band_pos = fract((UV.x - UV.y + TIME * speed) / width);
		if (band_pos < width) {
			color.rgb += brightness * color.a;
		}
	}

	COLOR = color;
}
