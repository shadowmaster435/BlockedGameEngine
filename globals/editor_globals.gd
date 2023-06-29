@tool
extends Node

var block_held_by_mouse = null
var block_hovered_by_mouse = null
var flow_held_by_mouse = null
var flow_hovered_by_mouse = null
var second_flow_hovered_by_mouse = null
var left_mouse = false
var right_mouse = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	pass

func get_held_block():
	return block_held_by_mouse

func update():
	left_mouse = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	right_mouse = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	pass
