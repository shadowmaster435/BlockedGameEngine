extends Node

@onready var registry = get_node("/root/Registry")
@onready var json_reader = get_node("/root/JsonReader")
var finished = false
var files = {}

func get_value_files():
	return registry.read_folder("value")
func _ready():
	create_registry()
func read_sub_value(dict):
	var result = {}
	for key in dict:
		var val = dict[key]
		if val is Dictionary:
			result[key].merge(read_sub_value(val))
		else:
			result[key] = val
	return result
func register_value(dict):
	var result = {}
	for key in dict:
		var entry = dict[key]
		for value_key in entry:
			var val = entry[value_key]
			if val is Dictionary:
				result.merge(read_sub_value(val))
			else:
				result[value_key] = val
	registry.add_assembled_registry("value", result)
func create_registry():
	var files = get_value_files()
	var assembled = {}
	for file in files:
		var val = files[file]
		var entries = json_reader.parse_file(val)
		if (entries != null):
			assembled[file] = entries
	register_value(assembled)
	finished = true
func get_value(k):
	return Registry.get_value("value", k)
