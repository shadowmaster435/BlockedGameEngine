extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func get_sprite_locations(input: Dictionary):
	var output = {}
	var dir = DirAccess
	for key in input:
		var val = input[key]
		var sub_result = {key: {}}
		for sub_key in val:

			var sub_val = val[sub_key]
			var sub_sub_result = {}	
			var path = "res://data/" + sub_val
			if (!DirAccess.dir_exists_absolute(path)):
				continue
			else:
				
				var files = dir.open(path).get_files()
				var directories = dir.open(path).get_directories()
				sub_sub_result[sub_key] = {}
				for file in files:
					sub_sub_result[sub_key].merge({file.substr(0, file.find(".")):"res://data/" + sub_val + "/" + file})
				for directory in directories:
					var sub_files = dir.open("res://data/" + sub_val + "/" + directory ).get_files()
					var sub_sub_sub_result = {directory:{}}
					for sub_file in sub_files:
						sub_sub_sub_result[directory].merge({sub_file.substr(0, sub_file.find(".")):"res://data/" + sub_val + "/" + directory + "/" + sub_file}) 
					sub_sub_result[sub_key].merge(sub_sub_sub_result)
				sub_result[key].merge(sub_sub_result)
			output = sub_result
	return output


	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
