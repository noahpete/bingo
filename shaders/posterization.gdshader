shader_type canvas_item;

uniform int levels: hint_range(2, 256);

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec3 color = texture(screen_texture, SCREEN_UV).rgb;
	color = floor(color * float(levels)) / float(levels);
	COLOR.rgb = color;
}