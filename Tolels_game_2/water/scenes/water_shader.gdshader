shader_type canvas_item;

// declare screen texture sampler
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Tint‑Farbe im Editor als Farb-Picker
uniform vec4 tint : source_color = vec4(1.0);

void fragment() {
    // Bild vom Bildschirm an der UV‑Koordinate holen
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
    // 40% tint über das Original mischen
    color = mix(color, tint, 0.3);
	color = mix(vec4(0.5),color,1.4);
    // in den Frame‑Buffer schreiben
    COLOR = color;
}





//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
