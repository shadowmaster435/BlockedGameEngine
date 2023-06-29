extends Node

var current_animations = {}
var current_steps = {}
var current_step_indexes = {}
var position_objects = {}
var current_variables = {}
var marked_for_deletion = []

func _ready():
	pass

func _process(delta):
	pass

func play(id):
	pass
func stop(id):
	current_animations.erase(id)
	current_variables.erase(id)
	position_objects[id].mark_for_deletion()
	position_objects.erase(id)
	current_steps.erase(id)
	current_step_indexes.erase(id)
	pass
func is_playing(id):
	return current_animations.has(id)
func update_object_and_vars(obj, key, delta):
	var val = position_objects[key]
	val.tick(delta)
	pass
func tick_objects(delta):
	for key in position_objects:
		var obj = position_objects[key]
		var mark_checker = position_objects[key].get_current_animation_vars()

		if (!marked_for_deletion.has(key)):
			if (mark_checker == "is_marked"):
				marked_for_deletion.append(key)
			else:
				update_object_and_vars(obj, key, delta)
				increment_steps()
	pass
func increment_steps():
	for key in current_variables:
		var val = current_variables[key]["length"]
		if (val <= 0):
			if (current_step_indexes[key] + 1 < current_steps[key].size()):
				current_step_indexes[key] = (current_step_indexes[key] + 1)
			else:
				position_objects[key].mark_for_deletion()
	pass
func tick(delta):
	tick_objects(delta)
	pass
