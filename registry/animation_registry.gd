extends Node

@onready var registry = get_node("/root/Registry")
@onready var json_reader = get_node("/root/JsonReader")
@onready var creator = get_node("/root/AnimationCreator")

var files = {}

func _ready():
	create_registry()
	pass

func _process(delta):
	pass

func get_animation_files():
	return registry.read_folder("animation")
func register(dict):

	registry.add_assembled_registry("animation", dict)
	pass
func get_value(k):
	return registry.get_value("animation", k)
func create_registry():
	var files = get_animation_files()
	var assembled = {}
	for file in files:
		var val = files[file]
		var entries = json_reader.parse_file(val)
		if (entries != null):
			assembled[file] = read_steps(entries)
	register(assembled)
	pass
func read_steps(step_dict):
	var variables = {"positions": {},"rotations": {},"curves": {}}
	var toggle_odd = false
	var half_count_reached = false
	var pos_counter = 0
	for variable in step_dict:
		if (variable != null):
			var val = step_dict[variable]
			for index in val:
				var sub_val = val[index]
				for entry_index in sub_val.size():
					if (sub_val[entry_index] != null):
						var is_positions = (variable == "positions" && entry_index + 1 < sub_val.size() && sub_val[entry_index + 1] != null)
						if (is_positions):
							if (pos_counter >= (sub_val.size() / 2)):
									half_count_reached = true
							if (!toggle_odd && !half_count_reached):
								variables["positions"].erase(sub_val[sub_val.size() - 1])
								var vec = Vector2(sub_val[entry_index], sub_val[entry_index + 1])
								variables["positions"].merge({pos_counter : vec})
								toggle_odd = true
							else:
								pos_counter += 1
								toggle_odd = false
						else:
							variables[variable].merge({entry_index : sub_val[entry_index]})
	variables["positions"].erase(((variables["positions"].size() - 1) * 2) - 1)

	return variables
