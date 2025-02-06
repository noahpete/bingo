shader_type canvas_item;

uniform float levels : hint_range(2, 256); // Number of color levels per channel.

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    vec3 color = texture(screen_texture, SCREEN_UV).rgb; // Sample the screen texture.
    color = floor(color * levels) / levels;
	COLOR.rgb = color;
}
