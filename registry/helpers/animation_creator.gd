extends Node

var id = "default"
var step_count = 0
var combined_length = 0
var lengths = {}
var positions = {}
var steps = {}
var held_obj_steps = {}

func _ready():
	pass

func _process(delta):
	pass

func finish_animation(id):
	var pre_clear = steps
	steps.clear()
	return {id: pre_clear}
func finish_step():
	steps[steps.size()] = held_obj_steps
	step_count += 1
	held_obj_steps.clear()
	pass
func create_object_step(id, length, pos: Vector2 = Vector2.ZERO, rot: float = 0, pos_curve: float = 1, rot_curve: float = 1):
	held_obj_steps[id] = {
		"length":length,
		"position":pos,
		"rotation":rot, 
		"pos_curve": pos_curve, 
		"rot_curve": rot_curve
	}
	pass
