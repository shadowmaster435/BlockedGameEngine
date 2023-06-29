extends Node

@onready var registry = get_node("/root/Registry")
@onready var json_reader = get_node("/root/JsonReader")
var files = {}

func get_menu_files():
	return registry.read_folder("menu")
	
func _ready():
	create_registry()
	pass

func register_menu(dict):
	for key in dict:

		MenuParser.parse_menu(dict[key], key)

	registry.add_assembled_registry("menu", dict)
	pass


func create_registry():
	var files = get_menu_files()
	var assembled = {}
	for file in files:
		var val = files[file]
		var entries = json_reader.parse_file(val)
		if (entries != null):
			assembled[file] = entries

	register_menu(assembled)
	pass

static func get_value(k):
	return Registry.get_value("menu", k)
	

func _process(delta):
	
	pass
