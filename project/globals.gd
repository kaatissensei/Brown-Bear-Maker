extends Node

var animals = []
var colors = []
var pageNum = 1

const possible_colors = [
	"RED",  "ORANGE", "YELLOW", "WEB_GREEN", "LAWN_GREEN",
	"DODGER_BLUE", "AQUA", "PURPLE", "PINK", "SADDLE_BROWN", 
	"WHITE", "BLACK"]
const simple_colors = [
	"RED",  "ORANGE", "YELLOW", "GREEN", "LIGHT GREEN",
	"BLUE", "LIGHT BLUE", "PURPLE", "PINK", "BROWN", 
	"WHITE", "BLACK"]

const possible_animals = [
	"Dog", "Cat", "Bear", "Bird", "Horse",
	 "Frog", "Sheep", "Fish", "Mouse", "Cow",
	 "Tiger", "Rabbit", "Dragon", "Snake", "Gorilla",
	 "Pig", "Dolphin", "Shark", "Elephant", "Lion", 
	 "Penguin", "Koala", "Giraffe", "Camel"
]
const animal_colors = [   #used for all animal flashcards
	"BURLYWOOD", "PURPLE", "SADDLE_BROWN", "RED", "CHOCOLATE",
	"GREEN", "BLACK", "RED", "GRAY", "BLACK",
	"ORANGE", "PINK", "FOREST_GREEN", "LAWN_GREEN", "DARK_SLATE_GRAY",
	"PINK", "SKY_BLUE", "DIM_GRAY", "GRAY", "GOLDENROD",
	"BLACK", "GRAY", "YELLOW", "ORANGE"
]

const bb_animals = ["Bear", "Bird", "Duck", "Horse", "Frog", "Cat", "Dog", "Sheep", "Goldfish"]
const bb_colors = ["SADDLE_BROWN", "RED", "YELLOW", "BLUE", "GREEN", "PURPLE", "WHITE", "BLACK", "GOLD"]

func _ready() -> void:
	animals.push_back("Bear")
	colors.push_back("SADDLE_BROWN")
	
func _set_animal_color(new_color):
	colors[pageNum-1] = new_color

func _get_animal_color(pNum = (pageNum - 1)):
	if colors[pNum] == "":
		return "SADDLE_BROWN"
	else:
		return colors[pNum]

#Convert Godot names to simple names
func get_simple_color(pNum = pageNum - 1):
	var color =  colors[pNum]
	return convert_to_simple_color(color)
	
func convert_to_simple_color(color_name):
	#var color = colors[pNum]
	match color_name.to_upper():
		"WEB_GREEN":
			return "GREEN" 
		"LAWN_GREEN":
			return "LIGHT GREEN"
		"DODGER_BLUE":
			return "BLUE" 
		"AQUA":
			return "LIGHT BLUE"
		"SADDLE_BROWN":
			return "BROWN"
		_:
			return color_name

func _set_animal(new_animal):
	animals[pageNum-1] = new_animal

func _get_animal(pNum = pageNum - 1):
	if animals[pNum] == "":
		return "Bear"
	else:
		return animals[pNum]

func next_page():
	if colors.size() <= pageNum: #if next page doesn't exist
		colors.push_back("SADDLE_BROWN")
		animals.push_back("Bear")
	if pageNum < 50:
		pageNum += 1

func previous_page():
	if pageNum > 1:
		pageNum -= 1

func load_bb_book():
	animals.clear()
	colors.clear()
	for i in range(bb_animals.size()):
		animals.push_back(bb_animals[i])
		colors.push_back(bb_colors[i])
	animals.push_back("Teacher")
	colors.push_back("BLACK")
	animals.push_back("Children")
	colors.push_back("BLACK")
	animals.push_back("LAST")
	
