@tool
extends Node

var block_held_by_mouse = null
var block_hovered_by_mouse = null
var flow_held_by_mouse = null
var flow_hovered_by_mouse = null
var second_flow_hovered_by_mouse = null
var left_mouse = false
var right_mouse = false
var middle_mouse = false
var scroll_up = false
var scroll_down = false
var active_tab = "foobar"
var hovered_tab = ""
var editor_states = {}

func _process(_delta):
	update()
func get_held_block():
	return block_held_by_mouse
func update():
	left_mouse = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	right_mouse = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	middle_mouse = Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE)
	scroll_up = Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP)
	scroll_down = Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN)
