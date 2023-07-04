@tool
extends Node2D

@export_category("Menu Variables")
@export var animation_progress := 1.0 as float
@export var menu_size = 512


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(animation_progress)
	get_node("NinePatchRect").size.x = menu_size * animation_progress
	pass
