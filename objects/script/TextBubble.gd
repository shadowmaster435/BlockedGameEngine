extends Node2D

var size_x = 0
var size_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	get_node("NinePatchRect").size = Vector2(size_x, size_y)
	pass
