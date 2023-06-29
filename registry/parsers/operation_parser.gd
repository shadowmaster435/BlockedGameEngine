extends Node
const operator_chars = ["+", "-", "/", "*", "%"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func split_operation_string(string: String) -> Dictionary:
	var split = {}
	var split_index = 0
	var spliting = ""
	var check_for_second_operator = false
	for char in string:
		if operator_chars.has(char):
			split[split_index] = spliting
			spliting = ""
			split_index += 1
			split[split_index] = char
			split_index += 1
			check_for_second_operator = true
		else:
			if check_for_second_operator && operator_chars.has(char):
				get_tree().quit()
			else:
				spliting = spliting + char
				check_for_second_operator = false
	return split
func parse_operation_string(string: String) -> float:
	var split = split_operation_string(string.replace(" ", ""))
	var result = 0
	for index in split.size() - 1:
		var in_bounds = index > 0 && index < split.size() - 2
		if in_bounds:
			var curr_val_str = split[index]
			var next_val_str = split[index + 1]
			var prev_val_str = split[index - 1]
			var is_operator = operator_chars.has(curr_val_str)
			var vals_exists = Registry.get_registry("value").has(prev_val_str) && Registry.get_registry("value").has(next_val_str)
			
			var add = is_operator && curr_val_str == "+"
			var sub = is_operator && curr_val_str == "-"
			var mul = is_operator && curr_val_str == "*"
			var div = is_operator && curr_val_str == "/"
			var mod = is_operator && curr_val_str == "%"
			if vals_exists:
				var prev_val = Registry.get_value("value", prev_val_str)
				var next_val = Registry.get_value("value", next_val_str)
				var first_val = result == 0
				if add:
					if first_val:
						result = prev_val + next_val
					else:
						result += next_val
				if sub:
					if first_val:
						result = prev_val - next_val
					else:
						result -= next_val
				if mul:
					if first_val:
						result = prev_val * next_val
					else:
						result *= next_val
				if div:
					if first_val:
						result = prev_val / next_val
					else:
						result /= next_val
				if mod:
					if first_val:
						result = prev_val % next_val
					else:
						result %= next_val
	return result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
