extends Node

# Generic Json Reader

func _ready():
	pass
func get_array(json_str, id):
	var json = JSON.parse_string(json_str)
func read_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	return file.get_as_text()
func parse_file(path):
	var json_str = read_file(path)
	var json = JSON.parse_string(json_str)
	
	return json
