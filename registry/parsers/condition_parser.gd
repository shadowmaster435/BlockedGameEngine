extends Node

func check(key: String):
	var cond = Registry.get_value("condition", key)
	var delims = cond["delims"]
	var strings = cond["strings"]
	var result = false
	for index in delims.size():
		var has_first = Registry.get_value("condition", key).has(strings[index])
		var has_second = Registry.get_value("condition", key).has(strings[index + 1])
		var first = cond[strings[index]] if has_first else  Registry.get_value("constant", strings[index])
		var second = cond[strings[index + 1]] if has_first else Registry.get_value("constant", strings[index + 1])
		var delim = delims[index]
		var initial_compare = compare(first, second, delim)
		var compared = compare_result(first, second, result, delim)
		result = initial_compare if index == 0 else compared
	return result
func compare(first, second, type):
	var result = false
	var EQUAL = "=="
	var AND = "&&"
	var OR = "||"
	var NOT_EQUAL = "!="
	var GREATER = ">"
	var LESS = "<"
	var GREATER_EQ = ">="
	var LESS_EQ = "<="
	var are_numbers = first is float && second is float

	if are_numbers:
		if type == EQUAL:
			result = first == second
		if type == NOT_EQUAL:
			result = first != second
		if type == GREATER:
			result = first > second
		if type == LESS:
			result = first < second
		if type == GREATER_EQ:
			result = first >= second
		if type == LESS_EQ:
			result = first <= second
	else:
		if type == EQUAL:
			result = first == second
		if type == NOT_EQUAL:
			result = first != second
		if type == AND:
			result = first && second
		if type == OR:
			result = first || second
	return result
func compare_result(first, second, current_result, type):
	return compare(current_result, compare(first, second, type), type)
	
