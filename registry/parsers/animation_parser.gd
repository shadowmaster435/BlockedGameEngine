extends Node

func parse_positions(value_dict: Dictionary):
	var result = {}
	for value_key in value_dict:
		var step_dict = value_dict[value_key]
		var value_index = StringHelper.get_int_safe(value_key)
		var parsed_step_dict = {value_index: {"x2": {}, "y2": {}, "x1": {}, "y1": {}, "curve": {}}}
		for step_value_key in step_dict:
			var step_value = step_dict[step_value_key]
			if step_value_key == "length":
				parsed_step_dict[value_index]["length"] = step_value
			if step_value_key == "x1":
				parsed_step_dict[value_index]["x1"] = step_value
			if step_value_key == "y1":
				parsed_step_dict[value_index]["y1"] = step_value
			if step_value_key == "x2":
				parsed_step_dict[value_index]["x2"] = step_value
			if step_value_key == "y2":
				parsed_step_dict[value_index]["y2"] = step_value
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
			if step_value_key == "rotation1":
				parsed_step_dict[value_index]["rotation1"] = step_value
			if step_value_key == "rotation2":
				parsed_step_dict[value_index]["rotation2"] = step_value
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
