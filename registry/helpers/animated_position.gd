extends Node2D

var start_pos = Vector2.ZERO
var end_pos = Vector2.ZERO
var start_rot = 0
var end_rot = 0
var current_pos = 0
var current_rot = 0
var current_life = 0
var lifespan = 0
var position_curve = 1
var rotation_curve = 1
var deletion_delay = 10
var marked = false

func _ready():
	pass

func delta():
	return (current_life + 0.001) / lifespan

func interpolate():
	var pos_ease = ease(delta(), position_curve)
	var rot_ease = ease(delta(), rotation_curve)
	var x = lerpf(start_pos.x, end_pos.x, pos_ease)
	var y = lerpf(start_pos.y, end_pos.y, pos_ease)
	current_pos = Vector2(x, y)
	current_rot = lerp_angle(start_rot, end_rot, rot_ease)
	pass

func tick(delta):
	if (current_life < lifespan):
		current_life += (1 + delta())
	interpolate()
	pass

func get_current_animation_vars():
	var dict = {"position": current_pos, "rotation": current_rot, "length": current_life}
	var is_marked = "is_marked"
	return dict if !marked else is_marked
	
func mark_for_deletion():
	marked = true
	pass

func _process(delta):
	if (marked):
		if (deletion_delay > 0):
			deletion_delay -= 1
		else:
			queue_free()
	pass
