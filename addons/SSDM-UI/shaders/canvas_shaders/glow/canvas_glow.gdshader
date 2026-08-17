shader_type canvas_item;

uniform float glow_enabled : hint_range(0.0, 1.0) = 0.0;
uniform float glow_intensity : hint_range(0.0, 5.0) = 1.0;
uniform vec4 glow_color : source_color = vec4(1.0);


void fragment() {
	vec4 color = texture(TEXTURE, UV);

	if (glow_enabled > 0.5 && color.a > 0.01) {
		color.rgb += glow_color.rgb * glow_intensity * color.a;
	}

	COLOR = color;
}
