@tool
extends Node2D
@onready var in_point = get_node("NinePatchRect/In")
@onready var out_point = get_node("NinePatchRect/Out")
@onready var rect = get_node("NinePatchRect")
var type = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_in_connected():
	return in_point.flow_lines
func get_out_connected():
	return out_point.flow_lines

func _process(delta):
	update_snap_points()

func update_snap_points():
	in_point.position.x = rect.size.x / 2
	in_point.position.y = -2
	out_point.position.x = rect.size.x / 2
	out_point.position.y = rect.size.y + 2
