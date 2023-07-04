@tool
extends Node2D

func _ready():
	pass
var style = "default"
var case = "upper"
var padding = 0
var letter = ""

var valid_capitals = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
var lowered = ["g","j","p","q","y"]
var numbers = ["0","1","2","3","4","5","6","7","8","9"]
var non_letter = [" ", "&", "$", "@", "!", "?", ",", ".", "'", "|", "/", "_", "[", "]", ";", ":", "=", "-", "*", "(", ")", "^", "%"]

var three_pixel_padding = ["z","0","1","a","x","v","r","o","y","q","p","f","k","j","g","b","u","d","h","n","c","A","B","C","D","E","F","H","J","O","P","Q","R","S","U","V","Z"]
var two_pixel_padding = []
var one_pixel_padding = ["T","t", "I", "L"]
var zero_pixel_padding = []
var nine_pixel_padding = ["W","X","M"]
var seven_pixel_padding = ["w"]
var five_pixel_padding = ["G","2","3","4","5","6","7","8","9","N","Y","K"]
var negative_three_pixel_padding = ["i","l",".","'", ","]

var comic_sans_negative_six = ["i", "l", ",", ".", "'"]
var comic_sans_negative_two = ["t", "j", "r", "s", "n", "v", "x"]
var comic_sans_zero = ["e"]
var comic_sans_one = []
var comic_sans_two = ["a", "w", "m"]
var comic_sans_three = []
var comic_sans_four = []
var comic_sans_lowered = ["p","q","y","g"]

func init(char, pos, style):

	var case_string = get_letter_case(char) + "case"
	var is_non_letter = non_letter.has(char)
	var is_number = numbers.has(char)
	var sub_location = "non_letter" if is_non_letter else "number" if is_number else case_string
	var legalized_char_path = "bslash" if char == "\\" else "fslash" if char == "/" else "asterisk" if char == "*" else "qmark" if char == "?" else str(char) 
	var path = "res://data/texture/typer/blank.png" if char == " "  else str("res://data/texture/typer/" + style + "/" + sub_location + "/" + legalized_char_path + ".png")
	position = pos
	self.style = style
	if (FileAccess.file_exists(path)):
		get_node("Letter").set_texture(load(path))
	else:
		var main = Main.debug_mode
		if (main.contains("dialogue") || main.debug_mode == "full"):
			print("Character Path '" + path + "' Does Not Exist")
			
	set_padding(char)
	if (lowered.has(char)):
		position = Vector2(pos.x, pos.y + 4)


func _process(_delta):
	pass

func get_letter_case(character):
	if (!valid_capitals.has(character)):
		return "lower"
	else:
		return "upper"

func set_padding(cha):
	if (cha == " "):
		padding = 8
	if (style == "comic_sans"):
		if (comic_sans_zero.has(cha)):
			padding = 0
		if (comic_sans_one.has(cha)):
			padding = 1
		if (comic_sans_two.has(cha)):
			padding = 2
		if (comic_sans_three.has(cha)):
			padding = 3
		if (comic_sans_four.has(cha)):
			padding = 4
		if (comic_sans_negative_six.has(cha)):
			padding = -6
		if (comic_sans_negative_two.has(cha)):
			padding = -2
		if (comic_sans_lowered.has(cha)):
			position.y = 2
		if ((cha == "e" || cha == "s")):
			position.x = position.x - 1
			position.y = position.y + 1
			scale = Vector2(1.75,1.75)
			padding = 4
	else:
		if (seven_pixel_padding.has(cha)):
			padding = 7
		if (nine_pixel_padding.has(cha)):
			padding = 9
		if (five_pixel_padding.has(cha)):
			padding = 5
		if (three_pixel_padding.has(cha)):
			padding = 3
		if (two_pixel_padding.has(cha)):
			padding = 2
		if (one_pixel_padding.has(cha)):
			padding = 1
		if (zero_pixel_padding.has(cha)):
			padding = 0
		if (negative_three_pixel_padding.has(cha)):
			padding = -3
		if ((cha == "e")):
			position.x = position.x - 1
			position.y = position.y + 1
			scale = Vector2(1.75,1.75)
			padding = 4
		if ((cha == "s")):
			position.x = position.x - 1
			position.y = position.y + 1
			scale = Vector2(1.75,1.75)

	if (cha == " "):
		padding = -4
	padding = padding + 8
	pass


