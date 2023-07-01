extends Node

# Helper Fuctions

func get_pos(animation, step, time):
	var dict = Registry.get_value("animation", animation)["positions"]
	var leng = Registry.get_value("length", animation)
	var curr = Util.get_index_clamped(dict, step)
	var next = Util.get_index_clamped(dict, step + 1)
	var x = lerpf(curr["x"], next["x"], ease(Util.to_delta(time, 0, leng), curr["curve"]["x"]))
	var y = lerpf(curr["y"], next["y"], ease(Util.to_delta(time, 0, leng), curr["curve"]["y"]))
	return Vector2(x, y)
func get_rot(animation, step, time):
	var dict = Registry.get_value("animation", animation)["rotations"]
	var leng = Registry.get_value("length", animation)
	var curr = Util.get_index_clamped(dict, step)
	var next = Util.get_index_clamped(dict, step + 1)
	var rot = lerp_angle(curr["rotation"], next["rotation"], ease(Util.to_delta(time, 0, leng), curr["curve"]))
	return rot
func get_rot_length(animation, step):
	var leng = Registry.get_value("animation", animation)["rotations"][step]["length"]
	return leng
func get_pos_length(animation, step):
	var leng = Registry.get_value("animation", animation)["positions"][step]["length"]
	return leng
