extends ColorRect

var card_number: int
var brown_bear: bool
var fc_mode: int  # 0-color, 1-bb_ani, 2-all_ani

var active_colors = []   #bool array of whether value should be included in list
var active_animals = []
var animal_list = []
var animal_color_list = []
var full_color_list = []

var bb_animals = []
var bb_colors = []

func _ready() -> void:
	bb_animals = Main.bb_animals
	bb_colors = Main.bb_colors
	brown_bear = true
	card_number = 1
	active_colors.resize(Main.possible_colors.size())
	active_animals.resize(Main.possible_animals.size())
	animal_color_list = Main.animal_colors
	full_color_list = Main.possible_colors
	
	for ac in active_colors:
		ac = true
	for aa in active_animals:
		aa = false
		
	#Set Brown Bear animals true
	for a in range(8):
		active_animals[a] = true
	for bb_ani in bb_animals:
		animal_list.push_back(bb_ani)
	
	#_set_active_cards() instead setting bb animals as default
	load_card()

func load_card():
	%FCAnimalColor.visible = true
	%ColoredCircle.visible = false
	if fc_mode == 0:
			%FCAnimalColor.visible = false
			%ColoredCircle.visible = true
			var cir_color = full_color_list[card_number - 1]
			var gradient_data = {
				0.62: Color(cir_color),
				0.625: Color8(0,0,0,0),
				}
			%ColoredCircle.texture.gradient.colors = gradient_data.values()
			
			%FlashcardText.text = Main.convert_to_simple_color(cir_color)
	else:
		var ani_color
		if fc_mode == 1:
			ani_color = bb_colors[card_number - 1]
		else:
			ani_color = animal_color_list[card_number - 1]
			animal_color_list = Main.animal_colors
			animal_list = Main.possible_animals
		
		%FCAnimalColor.visible = true
		%FlashcardText.text = animal_list[card_number - 1].to_lower()
		%FCAnimalImage.texture = load("res://images/%s.png" % animal_list[card_number - 1])
		
		%FCAnimalColor.color = Color(ani_color)
		if ani_color.to_upper() == "WHITE":
			%FCAnimalImage.material = load("res://inverse_material.tres")
		else:
			%FCAnimalImage.material = null
		
			
	
func _set_active_cards():
	for i in range(active_animals.size()):
		if active_animals[i] == true:
			animal_list.push_back(Main.possible_animals[i])
			
func _previous_card():
	if card_number > 1:
		card_number -= 1
	elif card_number == 1:
		card_number = get_num_flashcards()
	load_card()

func _next_card():
	var fc_num = get_num_flashcards()
	if card_number < fc_num:
		card_number += 1
		load_card()
	elif card_number == fc_num:
		card_number = 1
		load_card()

func get_num_flashcards():
	match fc_mode:
		0:
			return full_color_list.size()
		_:
			return animal_list.size()

func _show_flashcards(new_fc_mode) -> void:
	card_number = 1
	%Flashcards.visible = true
	fc_mode = new_fc_mode
	load_card()
	match fc_mode:
		0:  #color
			pass
		1:  #brown bear animals
			pass
		2:  #custom animals
			pass
		_:
			pass


func _exit() -> void:
	%Flashcards.visible = false
