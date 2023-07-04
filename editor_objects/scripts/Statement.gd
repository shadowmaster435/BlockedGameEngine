@tool
extends Node2D

@onready var top = get_node("TopSnap")
@onready var bottom = get_node("BottomSnap")
@onready var inner = get_node("InnerSnap")
@onready var rect = get_node("NinePatchRect")

func _ready():
	pass



func _process(delta):
	update_snap_points()

func update_snap_points():
	bottom.position.y = rect.size.y + 73
