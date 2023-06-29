extends Node
const operator_action_chars = {"+=": "+", "-=": "-", "/=": "/", "*=": "*", "%=": "%"}
const condition_action_chars = ["==", "<=", ">=", "&&", "!", "!=", "<", ">", "||"]
var separators = operator_action_chars.values() + condition_action_chars + ["="]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	pass
func open_menu(menu):
	pass
func get_operator_action_index(string: String):
	pass
func split_action(string: String):
	var val = ""
	var operator = ""
	var has_operators = StringHelper.contains_any(string, operator_action_chars.keys())
	var has_conditions = StringHelper.contains_any(string, condition_action_chars)
	val = string.substr(0, StringHelper.find_any(string, separators, false))
	operator = string.substr(StringHelper.find_any(string, separators, true))
	if !has_operators && !has_conditions:
		return {"value": val, "operator": operator}
	else:
		return {"value": val, "setter": operator}
func get_operator(string: String):
	return split_action(string)["operator"]
func get_value(string: String):
	return split_action(string)["value"]
func get_operation_result(string: String) -> float:
	return OperationParser.parse_operation_string(get_operator(string))
func parse_action(dict: Dictionary):
	for key in dict:
		var val = dict[key]
		var has_operators = StringHelper.contains_any(val, operator_action_chars.keys())
		var has_conditions = StringHelper.contains_any(val, condition_action_chars)
		if has_operators:
			GenericVariables.tracked_variables[get_value(val)] = get_operation_result(get_operator(val))
		elif val is Dictionary:
			parse_action(val)
		else:
			GenericVariables.tracked_variables[get_value(val)] = split_action(val["setter"])
	pass
