extends Control
const possible_colors = Main.possible_colors

func _ready() -> void:
	load_pallet()

func load_pallet():
	for color in possible_colors:
		var circle = TextureButton.new()
		circle.ignore_texture_size = true
		#circle.expand_mode = 2
		circle.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		circle.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		#Create gradient with two points
		var gradient = Gradient.new()
		var gradient_data = {
			0.62: Color(color),
			0.625: Color8(0,0,0,0),
			}
			
		gradient.offsets = gradient_data.keys()
		gradient.colors = gradient_data.values()
		
		#Create circle texture
		var texture = GradientTexture2D.new()
		texture.fill = GradientTexture2D.FILL_RADIAL
		texture.gradient = gradient
		texture.fill_from = Vector2(0.5, 0.5)
		texture.width = 256
		texture.height = 256
		
		#Add texture to circle
		circle.texture_normal = texture
		circle.name = color
		circle.connect("pressed", change_animal_color.bind(color))
		circle.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		add_child(circle)

func _scroll_right():
	var scroll_max = %ColorScroll.get_h_scroll_bar().max_value
	%ColorScroll.scroll_horizontal = scroll_max

func _scroll_left():
	%ColorScroll.scroll_horizontal = 0

func change_animal_color(new_color):
	var current_color = Main._get_animal_color()
	%AnimalColor.color = new_color
	Main._set_animal_color(new_color)
	%Page.update_text()
	%Page.update_animal()
	if new_color == "WHITE":
		for animal in get_tree().get_nodes_in_group("animals"):
			animal.material = load("res://inverse_material.tres")
	elif current_color == "WHITE":
		for animal in get_tree().get_nodes_in_group("animals"):
			animal.material = null
		
	
func _set_color_menu_visible(tf):
	%ColorPanel.visible = tf
	
