extends Node

@onready var registry = get_node("/root/Registry")
@onready var json_reader = get_node("/root/JsonReader")
var files = {}

func get_value_files():
	return registry.read_folder("value")
	
func _ready():
	create_registry()
	pass

func register_value(dict):

	registry.add_assembled_registry("value", dict)
	pass


func create_registry():
	var files = get_value_files()
	var assembled = {}
	for file in files:
		var val = files[file]
		var entries = json_reader.parse_file(val)
		if (entries != null):
			assembled[file] = entries
				
	register_value(assembled)
	pass

static func get_value(k):
	return Registry.get_value("value", k)
	

func _process(delta):
	
	pass
