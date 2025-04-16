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
	match ani:
		"Goldfish", "Teacher", "Children":
			col = ""
		_: 
			col = col + " "
	
	var col_ani = " %s%s," % [col, ani]
	%ColorAnimalText.text = col_ani + "\n" + col_ani
		
	dark_mode()
	#Set text color
	%ColorAnimalText.add_theme_color_override("default_color", Main._get_animal_color())
	if  color.to_upper() == "YELLOW" || color.to_upper() == "PINK": #can't use col because of the space added
		%ColorAnimalText.add_theme_color_override("font_outline_color", Color.BLACK)
		%ColorAnimalText.add_theme_constant_override("outline_size", 10)
		print("add outline")
	else:
		%ColorAnimalText.add_theme_constant_override("outline_size", 0)
	
	#Update ISee Text
	if (Main.pageNum >= Main.colors.size()):
		if ani == "Children":
			%ISeeText.text = ""
		else:
			%ISeeText.text = "I see a _____________\nlooking at me."
	else:
		var next_color = Main.get_simple_color(Main.pageNum)
		var article = "a "
		var outline = false
		match next_color.to_upper():
			"ORANGE":
				article = "an "
			"YELLOW", "WHITE", "PINK":
				outline = true
			_:
				outline = false
		
		###OUTLINE SIZE CANNOT BE SET TO 0 IN BBCODE
		var ICText 
		var color_text: String = Main._get_animal_color(Main.pageNum)
		var animal_text: String = Main._get_animal(Main.pageNum)
		var next_color_text: String = next_color[0].to_upper() + next_color.substr(1,-1).to_lower()
		#var next_col_ani
		
		if animal_text == "Children":
			article = ""
			
		match animal_text:
			"Goldfish", "Teacher", "Children":
				next_color_text = ""
			_: 
				next_color_text = next_color_text + " "
	
		if next_color == "BLACK" && color == "WHITE":
			ICText = "I see %s[color=%s][outline_size=10][outline_color=white]%s%s[/outline_color][/outline_size][/color]\nlooking at me." % \
			[article, 
			color_text, 
			next_color_text, 
			animal_text]
		elif outline:
			ICText = "I see %s[color=%s][outline_size=10]%s%s[/outline_size][/color]\nlooking at me." % \
			[article, 
			color_text, 
			next_color_text, 
			animal_text]
		elif ani == "Children":
			ICText = ""
		else:  #No outline
			ICText = "I see %s[color=%s]%s%s[/color]\nlooking at me." % \
			[article, 
			color_text, 
			next_color_text, 
			animal_text]
		%ISeeText.text = ICText.replace("  ", " ")

	

func update_animal(): #image
	var current_color = Main._get_animal_color()
	%AnimalColor.color = current_color
	var current_animal = Main._get_animal()
	%AnimalImage.texture = load("res://images/%s.png" % current_animal)
	
	#Update NextAnimal
	if Main.colors.size() > Main.pageNum:
		var next_color = Main._get_animal_color(Main.pageNum)
		%NextAnimalColor.color = next_color
		var next_animal = Main._get_animal(Main.pageNum)
		if next_animal!= "LAST":
			%NextAnimalImage.texture = load("res://images/%s.png" % next_animal)
		else:
			%NextAnimalImage.texture = null
		%NextAnimalColor.visible = true
		if next_color.to_upper() == "WHITE":
			%NextAnimalImage.material = load("res://inverse_material.tres")
		else:
			%NextAnimalImage.material = null
		
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
	if Main.animals[Main.pageNum-1] != "LAST":
		Main.next_page()
		if Main.animals[Main.pageNum-2] == "Children":
				load_last_page()
				%PageNumber.text = str(Main.pageNum)
		else:
			turn_page()
		%PreviousPage.visible = true
	
func _previous_page():
	if Main.animals[Main.animals.size()-1] == "LAST" && Main.pageNum == 1:
			Main.pageNum = Main.animals.size()
	else:
		%LastPage.visible = false
		Main.previous_page()
		turn_page()
		if Main.pageNum == 1:
			%PreviousPage.visible = false

func turn_page():
	%PageNumber.text = str(Main.pageNum)
	update_text()
	update_animal()
	%AnimalPanel.visible = false
	%AnimalMenuButton.button_pressed = false
	%ColorPanel.visible = false
	%ColorMenuButton.button_pressed = false


func _open_menu() -> void:
	if %Menu.is_visible_in_tree():
		%Menu.visible = false
	else:
		%Menu.visible = true


func _hide_menu() -> void:
	%Menu.visible = false

func _load_brown_bear():
	Main.load_bb_book()
	update_animal()
	update_text()
	%Menu.visible = false
		
func load_last_page():
	var animal_square 
	var animals_in_book = Main.animals
	var colors_in_book = Main.colors
	
	%LastPage.visible = true
	if %WeSeeGrid.get_child_count() == 0:
		for i in range(animals_in_book.size() - 3):
			animal_square = load("res://animal_color_and_image.tscn").instantiate()
			animal_square.color = colors_in_book[i]
			animal_square.get_child(0).texture = load("res://images/%s.png" % animals_in_book[i])
			if colors_in_book[i] == "WHITE":
				animal_square.get_child(0).material = load("res://inverse_material.tres")
			%WeSeeGrid.add_child(animal_square)
		
	

func _hide_last_page() -> void:
	%LastPage.visible = false


func _exit_book() -> void:
	%LastPage.visible = false
	Main.pageNum = 1
	update_animal()
	update_text()
