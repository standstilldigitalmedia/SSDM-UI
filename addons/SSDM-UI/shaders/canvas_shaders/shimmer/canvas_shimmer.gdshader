shader_type canvas_item;

uniform float shimmer_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float shimmer_speed : hint_range(0.0, 20.0) = 2.0;
uniform float shimmer_width : hint_range(0.01, 1.0) = 0.2;
uniform float shimmer_brightness : hint_range(0.0, 2.0) = 0.5;


void fragment() {
	vec4 color = texture(TEXTURE, UV);

	if (shimmer_enabled > 0.5) {
		float band_pos = fract((UV.x - UV.y + TIME * shimmer_speed) / shimmer_width);
		if (band_pos < shimmer_width) {
			color.rgb += shimmer_brightness * color.a;
		}
	}

	COLOR = color;
}
