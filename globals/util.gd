extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func to_tf3d(tf: Transform2D):
	var result = Transform3D(
		Vector3(tf.x.x, tf.x.y, 0),
		Vector3(tf.y.x, tf.y.y, 0),
		Vector3(0,0, 1),
		Vector3(tf.origin.x, tf.origin.y, 0),
	)
	return result
func get_letter_padding(cha, style: String = "text_box"):
	var padding = 0
	
	var three_pixel_padding = ["z","a","x","v","r","o","y","q","p","f","k","j","g","b","u","d","h","n","c","A","B","C","D","E","F","H","J","O","P","Q","R","S","U","V","Z"]
	var two_pixel_padding = []
	var one_pixel_padding = ["T","t", "I", "L"]
	var zero_pixel_padding = ["s"]
	var nine_pixel_padding = ["W","X","M"]
	var seven_pixel_padding = ["w","m"]
	var five_pixel_padding = ["G","4","5","N","Y","K"]
	var negative_three_pixel_padding = ["i","l",".","'", ","]

	var comic_sans_negative_six = ["i", "l", ",", ".", "'"]
	var comic_sans_negative_two = ["t", "j", "r", "s", "n", "v", "x"]
	var comic_sans_zero = ["e"]
	var comic_sans_one = []
	var comic_sans_two = ["a", "w", "m"]
	var comic_sans_three = []
	var comic_sans_four = []
	var comic_sans_lowered = ["p","q","y","g"]
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
		if ((cha == "e" || cha == "s")):
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

	padding = padding + 8
	return padding
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
