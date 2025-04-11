extends Node

var animals = []
var colors = []
var pageNum = 1

const possible_colors = [
	"RED",  "ORANGE", "YELLOW", "WEB_GREEN", "LAWN_GREEN",
	"DODGER_BLUE", "AQUA", "PURPLE", "PINK", "SADDLE_BROWN", 
	"WHITE", "BLACK"]

const possible_animals = [
	"Dog", "Cat", "Bear", "Bird", "Horse",
	 "Frog", "Sheep", "Fish", "Mouse", "Cow",
	 "Tiger", "Rabbit", "Dragon", "Snake", "Gorilla",
	 "Pig", "Dolphin", "Shark", "Elephant", "Lion", 
	 "Penguin", "Koala", "Giraffe", "Camel"
]
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
	var color = colors[pNum]
	match color.to_upper():
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
			return color

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
	pageNum += 1

func previous_page():
	if pageNum > 1:
		pageNum -= 1
