shader_type spatial;

uniform sampler2D noise_texture : hint_default_black;
uniform float radius : hint_range(0.0, 1.0) = 0.5; // Control the size of the circle

void fragment() {
    // Get the texture coordinates of the fragment
    vec2 center = vec2(0.5, 0.5); // Center of the sprite (normalized coordinates)
    vec2 uv = FRAGCOORD.xy / 1.0; // Fragment's coordinates in UV space
    
    // Calculate the distance from the center of the texture
    float dist = distance(uv, center);
    
    // If the distance is greater than the radius, discard the fragment
    if (dist > radius) {
        discard;
    }

    // Sample the noise texture
    vec4 noise_sample = texture(noise_texture, uv);
    
    // Set the final color (you can modify this based on the noise texture's value)
    ALBEDO = noise_sample.rgb;
}
