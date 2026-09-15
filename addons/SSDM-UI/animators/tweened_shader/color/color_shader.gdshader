shader_type canvas_item;

uniform vec4 bg_color : source_color = vec4(1.0);
uniform float color_enabled : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	COLOR = bg_color;
}