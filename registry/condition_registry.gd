extends Node

@onready var registry = get_node("/root/Registry")
@onready var json_reader = get_node("/root/JsonReader")
var finished = false
var files = {}
const condition_chars = ["==", "<=", ">=", "&&", "!=", "<", ">", "||"]

func split(string:String):
	return StringHelper.to_sliced_dictionary(string, condition_chars)
func get_condition_files():
	return registry.read_folder("condition")
func _ready():
	create_registry()
func register_constant(key, val):
	Registry.register("constant", key, val)
func register_conditions(dict):
	var result = {}
	for key in dict:
		var val = dict[key]
		var sub_result = {}
		for sub_key in val:
			var sub_val = val[sub_key]
			if sub_key == "return":
				sub_result = split(sub_val)
			else:
				register_constant(sub_key, sub_val)
		result[key] = sub_result
	registry.add_assembled_registry("condition", result)

func create_registry():
	var files = get_condition_files()
	var assembled = {}
	for file in files:
		var val = files[file]
		var entries = json_reader.parse_file(val)
		if (entries != null):
			assembled[file] = entries
	register_conditions(assembled)
	finished = true
func get_value(k):
	return Registry.get_value("condition", k)
