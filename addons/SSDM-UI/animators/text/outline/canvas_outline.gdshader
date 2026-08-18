shader_type canvas_item;

uniform float shader_enabled : hint_range(0.0, 1.0) = 0.0;
uniform vec4 outline_color : source_color = vec4(1.0);
uniform float outline_size : hint_range(0.0, 10.0) = 1.0;


void fragment() {
	vec4 color = texture(TEXTURE, UV);

	if (shader_enabled > 0.5) {
		if (color.a < 0.5) {
			vec2 ps = TEXTURE_PIXEL_SIZE * outline_size;
			float n = texture(TEXTURE, UV + vec2(0.0, -ps.y)).a;
			float s = texture(TEXTURE, UV + vec2(0.0,  ps.y)).a;
			float e = texture(TEXTURE, UV + vec2( ps.x, 0.0)).a;
			float w = texture(TEXTURE, UV + vec2(-ps.x, 0.0)).a;
			if (n > 0.5 || s > 0.5 || e > 0.5 || w > 0.5) {
				color = outline_color;
			}
		}
	}

	COLOR = color;
}
