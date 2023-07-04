extends Node

@onready var registry = get_node("/root/Registry")
@onready var json_reader = get_node("/root/JsonReader")
var files = {}
var finished = false
func get_sprite_trees():
	return registry.read_folder("sprite_tree")
func _ready():
	create_registry()
	pass
func register_sprite(dict: Dictionary):
	var paths = SpriteTreeParser.get_sprite_locations(dict)
	registry.add_assembled_registry("sprite_tree", paths)
	pass
func create_registry():
	var files = get_sprite_trees()
	var assembled = {}
	for file in files:
		var val = files[file]
		var entries = json_reader.parse_file(val)
		if (entries != null):
			assembled[file] = entries
	register_sprite(assembled)
	finished = true
static func get_value(k):
	return Registry.get_value("sprite_tree", k)
func _process(_delta):
	pass
