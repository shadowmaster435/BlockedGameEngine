extends Node

func parse_positions(value_dict: Dictionary):
	var result = {}
	for value_key in value_dict:
		var step_dict = value_dict[value_key]
		var value_index = StringHelper.get_int_safe(value_key)
		var parsed_step_dict = {value_index: {"x": {}, "y": {}, "curve": {}}}
		for step_value_key in step_dict:
			var step_value = step_dict[step_value_key]
			if step_value_key == "length":
				parsed_step_dict[value_index]["length"] = step_value
			if step_value_key == "x":
				parsed_step_dict[value_index]["x"] = step_value
			if step_value_key == "y":
				parsed_step_dict[value_index]["y"] = step_value
			if step_value_key == "curve":
				if step_value is Dictionary:
					parsed_step_dict[value_index]["curve"] = {"x": step_value["x"], "y": step_value["y"]}
				else:
					parsed_step_dict[value_index]["curve"] = {"x": step_value, "y": step_value}
			pass
		result.merge(parsed_step_dict)
	return result
func parse_rotations(value_dict: Dictionary):
	var result = {}
	for value_key in value_dict:
		var step_dict = value_dict[value_key]
		var value_index = StringHelper.get_int_safe(value_key)
		var parsed_step_dict = {value_index: {}}
		for step_value_key in step_dict:
			var step_value = step_dict[step_value_key]
			if step_value_key == "length":
				parsed_step_dict[value_index]["length"] = step_value
			if step_value_key == "rotation":
				parsed_step_dict[value_index]["rotation"] = step_value
			if step_value_key == "curve":
				parsed_step_dict[value_index]["curve"] = step_value
			pass
		result.merge(parsed_step_dict)
	return result
func parse_animation(animation: Dictionary) -> Dictionary:
	var result = {"positions": {}, "rotations": {}}
	for value_key in animation:
		var read_value = animation[value_key]
		if value_key == "positions":
			result["positions"] = parse_positions(read_value)
		if value_key == "rotations":
			result["rotations"] = parse_rotations(read_value)
	return result
