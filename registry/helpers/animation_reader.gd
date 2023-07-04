extends Node

# Helper Fuctions

func get_pos(animation, step, time):
	var dict = Registry.get_value("animation", animation)["positions"]
	var leng = Registry.get_value("animation", animation)["positions"][clamp(step, 0, Registry.get_value("animation", animation)["positions"].size() - 1)]["length"]
	var curr = Util.get_index_clamped(dict, step)
	var next = Util.get_index_clamped(dict, step + 1)
	
	var x = lerpf(float(curr["x1"]), float(curr["x2"]), ease(Util.to_delta(time, 0, leng), curr["curve"]["x"]))
	var y = lerpf(float(curr["y1"]), float(curr["y2"]), ease(Util.to_delta(time, 0, leng), curr["curve"]["y"]))

	return Vector2(x, y)
func get_rot(animation, step, time):
	var dict = Registry.get_value("animation", animation)["rotations"]
	var leng = Registry.get_value("animation", animation)["rotations"][clamp(step, 0, Registry.get_value("animation", animation)["rotations"].size() - 1)]["length"]
	var curr = Util.get_index_clamped(dict, step)

	var rot = lerp_angle(deg_to_rad(curr["rotation1"]), deg_to_rad(curr["rotation2"]), ease(Util.to_delta(time, 0, leng), curr["curve"]))

	return rot
func get_rot_length(animation, step):

	var leng = Registry.get_value("animation", animation)["rotations"][clamp(step, 0, get_rot_step_count(animation) - 1)]["length"]
	return leng
func get_pos_length(animation, step):
	var leng = Registry.get_value("animation", animation)["positions"][clamp(step, 0, get_pos_step_count(animation) - 1)]["length"]

	return leng
func get_pos_step_count(animation):
	return Registry.get_value("animation", animation)["positions"].size()
func get_rot_step_count(animation):
	return Registry.get_value("animation", animation)["rotations"].size()
