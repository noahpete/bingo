shader_type spatial;

uniform sampler2D albedo_sampler;
uniform sampler2D noise_sampler;

uniform float progress;

uniform vec4 emission_color;


void fragment() {
	vec4 color_texture = texture(albedo_sampler, UV);
	vec4 nosie_texture = texture(noise_sampler, UV);
	
	// Singed outline effect
	if (progress > 0.0) {
		float offset_progress = progress + 0.1;
		vec4 light_color = mix(vec4(0.0), emission_color, offset_progress);
		EMISSION = vec3(step(nosie_texture.r, light_color.rgb));
		ALPHA_SCISSOR_THRESHOLD = progress;
		ALPHA = nosie_texture.r;
	}
	
	ALBEDO = color_texture.rgb;
}
