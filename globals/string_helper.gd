extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func isolate_id(uuid):
	return str(uuid).get_slice("|", 1)

func gen_uuid(length, identifier):
	var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"] 
	var numbers = ["0","1","2","3","4","5","6","7","8","9"]
	var result = ""
	for index in length:
		var letter_index = randi_range(0, 25)
		var number_index = randi_range(0, 9)
		if (randf() > 0.5):
			var letter = letters[letter_index]
			if (randf() > 0.5):
				result = result + letter.capitalize()
			else:
				result = result + letter
		else:
			result = result + numbers[number_index]
	return result + "|" + identifier


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
