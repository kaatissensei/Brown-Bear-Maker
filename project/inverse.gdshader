shader_type canvas_item;

void fragment(){
	vec4 color = texture(TEXTURE, UV);
	if (color.r > 0.95 && color.g > 0.99 && color.b > 0.95) {
		COLOR = vec4(1.0 - color.rgb, color.a);
		}
}
