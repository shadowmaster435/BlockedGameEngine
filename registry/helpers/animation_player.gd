extends Node

var tracked = {}
var paused = {}

func _process(delta):
	update()
func play(id, animation):
	tracked[id].merge({animation : {"values": {"pos": AnimationReader.get_pos(animation, 0, 0), "rot": AnimationReader.get_rot(animation, 0, 0)} ,"time": {"rot": 0, "pos": 0}, "length": {"rot":  AnimationReader.get_rot_length(animation, 0), "pos":  AnimationReader.get_rot_length(animation, 0)}, "step": {"rot": 0, "pos": 0}}})
func stop_all(id):
	tracked.erase(id)
func stop(id, animation):
	tracked[id].erase(animation)
func pause_all(id):
	paused[id] = tracked[id]
	tracked.erase(id)
func pause(id, animation):
	paused[id].merge({id: animation})
	tracked[id][animation].erase(animation)
func resume_all(id):
	tracked[id] = paused[id]
	paused.erase(id)
func resume(id, animation):
	tracked[id][animation].merge({id: animation})
	paused[id][animation].erase(animation)
func update():
	for id in tracked:
		var anims = tracked[id]
		for anim_key in anims:
			inc_steps(id, anim_key)
	pass
func inc_steps(id, animation):
	var pos_step = get_pos_anim_step(id, animation)
	var rot_step = get_rot_anim_step(id, animation)
	if get_pos_anim_time(id, animation) <= 0:
		tracked[id][animation]["time"]["pos"] = get_pos_anim_length(id, animation)
		tracked[id][animation]["step"]["pos"] += 1
	else:
		tick_pos_anim_time(id, animation)
	if get_rot_anim_time(id, animation) <= 0:
		tracked[id][animation]["time"]["rot"] = get_pos_anim_length(id, animation)
		tracked[id][animation]["step"]["rot"] += 1
	else:
		tick_rot_anim_time(id, animation)
	tick_animations(id, animation)
func get_rot_anim_time(id, animation):
	return tracked[id][animation]["time"]["rot"]
func get_rot_anim_length(id, animation):
	return tracked[id][animation]["length"]["rot"]
func tick_rot_anim_time(id, animation):
	tracked[id][animation]["time"]["rot"] -= 1
func get_rot_anim_step(id, animation):
	tracked[id][animation]["step"]["rot"] -= 1
func get_pos_anim_time(id, animation):
	return tracked[id][animation]["time"]["pos"]
func get_pos_anim_length(id, animation):
	return tracked[id][animation]["length"]["pos"]
func tick_pos_anim_time(id, animation):
	tracked[id][animation]["time"]["pos"] -= 1
func get_pos_anim_step(id, animation):
	return tracked[id][animation]["length"]["pos"]
func tick_pos_anim_step(id, animation):
	tracked[id][animation]["step"]["pos"] -= 1
func tick_animations(id, animation):
	tracked[id][animation]["values"]["pos"] = AnimationReader.get_pos(animation, get_pos_anim_step(id, animation), get_pos_anim_time(id, animation))
	tracked[id][animation]["values"]["pos"] = AnimationReader.get_pos(animation, get_rot_anim_step(id, animation), get_rot_anim_time(id, animation))
	pass
