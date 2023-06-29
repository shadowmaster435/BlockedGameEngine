extends Node

@onready var registry = get_node("/root/Registry")
const dict = {
}

func _ready():
	build()
	pass # Replace with function body.

func get_value(k) -> PackedScene:
	var node := dict[k] as PackedScene
	return node
func get_value_instantiated(k) -> Node:
	var node := dict[k] as PackedScene
	return node.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
func build():

	registry.add_assembled_registry("object", dict)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
