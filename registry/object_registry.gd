extends Node

@onready var registry = get_node("/root/Registry")
const dict = {
	"pl": player,
	"player": player,
	"pt": platform,
	"platform": platform,
	"ty": typer,
	"typer": typer,
	"bb": battle_box,
	"battle_box": player
}

func _ready():
	build()
	pass # Replace with function body.
const player = preload("res://objects/Player.tscn")
const platform = preload("res://objects/Platform.tscn")
const battle_box = preload("res://objects/BattleBox.tscn")
const typer = preload("res://objects/Typer.tscn")

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
