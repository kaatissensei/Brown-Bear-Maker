extends Node

func _ready() -> void:
	load_colors()
	update_animal()
	
func load_colors():
	pass

func update_text():
	#Update ColorAnimalText
	var ani: String = Main._get_animal()
	var color: String = Main.get_simple_color()
	var col: String = color[0].to_upper() + color.substr(1,-1).to_lower()
	var col_ani = " %s %s," % [col, ani]
	%ColorAnimalText.text = col_ani + "\n" + col_ani
		
	dark_mode()
	#Set text color
	%ColorAnimalText.add_theme_color_override("default_color", Main._get_animal_color())
	if col.to_upper() == "WHITE" || col.to_upper() == "YELLOW":
		%ColorAnimalText.add_theme_color_override("font_outline_color", Color.BLACK)
		%ColorAnimalText.add_theme_constant_override("outline_size", 10)
	else:
		%ColorAnimalText.add_theme_constant_override("outline_size", 0)
	
	#Update ISee Text
	if (Main.colors.size() <= Main.pageNum):
		%ISeeText.text = "I see a _____________\nlooking at me."
	else:
		var next_color = Main.get_simple_color(Main.pageNum)
		var next_col: String = next_color[0].to_upper() + next_color.substr(1,-1).to_lower()
		var article = "a"
		var outline_size = "0"
		match next_col.to_upper():
			"ORANGE":
				article = "an"
			"YELLOW":
				outline_size = "10"
			"WHITE":
				outline_size = "10"
			_:
				outline_size = "0"
		
		var ICText = "I see %s [outline_size=%s][color=%s]%s %s[/color][/outline_size]\nlooking at me." % \
		[article, 
		outline_size,
		Main._get_animal_color(Main.pageNum), 
		next_col, 
		Main._get_animal(Main.pageNum)]
		 
		%ISeeText.text = ICText
	#Set text color
	#if col.to_upper() == "WHITE" || col.to_upper() == "YELLOW":
		#%ISeeText.add_theme_color_override("font_outline_color", Color.BLACK)
		#%ISeeText.add_theme_constant_override("outline_size", 10)
	#else:
		#%ISeeText.add_theme_constant_override("outline_size", 0)

func update_animal():
	%AnimalColor.color = Main._get_animal_color()
	var current_animal = Main._get_animal()
	%AnimalImage.texture = load("res://images/%s.png" % current_animal)
	
	#Update NextAnimal
	if Main.colors.size() > Main.pageNum:
		%NextAnimalColor.color = Main._get_animal_color(Main.pageNum)
		var next_animal = Main._get_animal(Main.pageNum)
		%AnimalImage.texture = load("res://images/%s.png" % next_animal)
		%NextAnimalColor.visible = true
	else:
		%NextAnimalColor.visible = false

func dark_mode():
	if Main._get_animal_color() == "WHITE": #turn on dark mode
		for text in get_tree().get_nodes_in_group("text"):
			text.add_theme_color_override("default_color", Color.WHITE)
		%Page.color = Color.BLACK
		%AnimalImage.material = load("res://inverse_material.tres")
	else: #turn off
		for text in get_tree().get_nodes_in_group("text"):
			text.add_theme_color_override("default_color", Color.BLACK)
		%Page.color = Color.WHITE
		%AnimalImage.material = null
		

	
func _next_page():
	Main.next_page()
	turn_page()
	
func _previous_page():
	Main.previous_page()
	turn_page()

func turn_page():
	%PageNumber.text = str(Main.pageNum)
	update_text()
	update_animal()
	%AnimalPanel.visible = false
	%AnimalMenuButton.button_pressed = false
	%ColorPanel.visible = false
	%ColorMenuButton.button_pressed = false
