extends Node

@onready var registry = get_node("/root/Registry")
@onready var json_reader = get_node("/root/JsonReader")
@onready var creator = get_node("/root/AnimationCreator")
var finished = false
var files = {}

func _ready():
	create_registry()
func get_animation_files():
	return registry.read_folder("animation")
func register(dict):
	registry.add_assembled_registry("animation", dict)
func get_value(k):
	return registry.get_value("animation", k)
func create_registry():
	var files = get_animation_files()
	var assembled = {}
	for file in files:
		var val = files[file]
		var entries = json_reader.parse_file(val)
		if (entries != null):
			assembled[file] = AnimationParser.parse_animation(entries)
	register(assembled)
	finished = true

