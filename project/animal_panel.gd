extends Control
const possible_animals = Main.possible_animals

func _ready() -> void:
	load_zoo()
	%AnimalPanelColor.color = Main._get_animal_color()
	
func load_zoo():
	for animal in possible_animals:
		var square = TextureButton.new()
		square.texture_normal = load("res://images/%s.png" % animal)
		square.ignore_texture_size = true
		square.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		square.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		square.size_flags_vertical = Control.SIZE_EXPAND_FILL
		square.name = animal
		square.connect("pressed", change_animal.bind(animal))
		square.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		square.add_to_group("animals")
		add_child(square)
		square.z_index = 1

func change_animal(new_animal):
	%AnimalImage.texture = load("res://images/%s.png" % new_animal)
	Main._set_animal(new_animal)
	%Page.update_text()
	%AnimalMenuButton.button_pressed = false
	%AnimalPanel.visible = false

func _set_animal_menu_visible(tf):
	%AnimalPanel.visible = tf
	if tf:
		%AnimalPanelColor.color = Main._get_animal_color()
