extends Node

@onready var registry = get_node("/root/Registry")
var finished = false
# Currently used to register nodes through code by
# entering a dictionary entry into the const below
# i.e. {"foo" : reference_to_node}

const dict = {
}
func _ready():
	build()
func get_value(k) -> PackedScene:
	var node := dict[k] as PackedScene
	return node
func get_value_instantiated(k) -> Node:
	var node := dict[k] as PackedScene
	return node.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
func build():
	registry.add_assembled_registry("object", dict)
	finished = true
