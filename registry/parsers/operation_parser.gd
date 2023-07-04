extends Node
const operator_chars = ["+", "-", "/", "*", "%"]
var SIN = "sin"
var COS = "cos"
var TAN = "tan"
var FLOOR = "floor"
var CEIL = "ceil"
var ROUND = "round"
var RANDOM = "rand"
var RAND_RANGE = "rand_range"
var POW = "pow"
var EXP = "exp"
var LOG = "log"
var LERP = "lerp"
var LERP_ANGLE = "lerp_angle"
var MIN = "min"
var MAX = "max"
var CLAMP = "clamp"
var RAD_TO_DEG = "to_deg"
var DEG_TO_RAD = "to_rad"
var SMOOTH_STEP = "smoothstep"
var ASIN = "asin"
var ACOS = "acos"
var ATAN = "atan"
var ATAN2 = "atan2"
var ABS = "abs"
var SQRT = "sqrt"
var all = ["random()", LERP, SMOOTH_STEP, CLAMP, LERP_ANGLE, ATAN2, POW, RAND_RANGE, MIN, MAX, SIN, ASIN, COS, ACOS, TAN, ATAN, ABS,RAD_TO_DEG, DEG_TO_RAD, LOG, EXP, FLOOR, CEIL, SQRT]

func calculate_normal(first, second, type):
	var result = 0
	var ADD = "+"
	var SUB = "-"
	var MUL = "*"
	var DIV = "/"
	var MOD = "%"

	if type == ADD:
		result = first + second
	elif type == SUB:
		result = first - second
	elif type == MUL:
		result = first * second
	elif type == DIV:
		result = first / second
	elif type == MOD:
		result = fmod(first, second)
	return result
func calculate_special(type, inputs: Dictionary):
	var result = 0
	var first
	var second
	var third
	if inputs.size() >= 3:
		third = Registry.get_value("value", inputs["strings"][2]) if Registry.get_registry("value").has(inputs["strings"][2]) else Registry.get_value("constant", inputs["strings"][2])
	if inputs.size() >= 2:
		second = Registry.get_value("value", inputs["strings"][1]) if Registry.get_registry("value").has(inputs["strings"][1]) else Registry.get_value("constant", inputs["strings"][1])
	if inputs.size() >= 1:
		first = Registry.get_value("value", inputs["strings"][0]) if Registry.get_registry("value").has(inputs["strings"][0]) else Registry.get_value("constant", inputs["strings"][0])
	if input_count_of(type) == inputs.size():
		if type == "random()":
			result = randf()
		elif type == SIN:
			result = sin(first)
		elif type == COS:
			result = cos(first)
		elif type == TAN:
			result = tan(first)
		elif type == ASIN:
			result = asin(first)
		elif type == ACOS:
			result = acos(first)
		elif type == ATAN:
			result = atan(first)
		elif type == EXP:
			result = exp(first)
		elif type == LOG:
			result = log(first)
		elif type == CEIL:
			result = ceil(first)
		elif type == FLOOR:
			result = floor(first)
		elif type == SQRT:
			result = sqrt(first)
		elif type == DEG_TO_RAD:
			result = deg_to_rad(first)
		elif type == RAD_TO_DEG:
			result = rad_to_deg(first)
		elif type == ATAN2:
			result = atan2(first, second)
		elif type == POW:
			result = pow(first, second)
		elif type == RAND_RANGE:
			result = randf_range(first, second)
		elif type == MIN:
			result = min(first, second)
		elif type == MAX:
			result = max(first, second)
		elif type == LERP:
			result = lerp(first, second, third)
		elif type == SMOOTH_STEP:
			result = max(first, second, third)
		elif type == CLAMP:
			result = max(first, second, third)
		elif type == LERP_ANGLE:
			result = max(first, second, third)
	return result
func parse(string: String):
	var all = ["random", LERP, SMOOTH_STEP, CLAMP, LERP_ANGLE, ATAN2, POW, RAND_RANGE, MIN, MAX, SIN, ASIN, COS, ACOS, TAN, ATAN, ABS,RAD_TO_DEG, DEG_TO_RAD, LOG, EXP, FLOOR, CEIL, SQRT]
	for index in all.size() - 1:
		all[index] = all[index] + "("
	print(StringHelper.to_sliced_dictionary(string, all + operator_chars))
	return StringHelper.to_sliced_dictionary(string, all + operator_chars)
func input_count_of(val):
	var one_input = [SIN, ASIN, COS, ACOS, TAN, ATAN, ABS,RAD_TO_DEG, DEG_TO_RAD, LOG, EXP, FLOOR, CEIL, SQRT]
	var two_input = [ATAN2, POW, RAND_RANGE, MIN, MAX]
	var three_input = [LERP, SMOOTH_STEP, CLAMP, LERP_ANGLE]
	return 1 if one_input.has(val) else 2 if two_input.has(val) else 3 if three_input.has(val) else 0
func calculate_result(first, second, type):
	return calculate_normal(first, second, type) #if !all.has(type) else calculate_special(calculate_special(dict, type), dict)
func calculate_result_initial(first, second, type):	
	return calculate_normal(first, second, type)# if !all.has(type) else calculate_special(dict["strings"], dict["delims"])
func calculate(key: String):
	var oper = Registry.get_value("operation", key)
	var delims = oper["delims"]
	var strings = oper["strings"]
	var result = 0
	for index in delims.size():
		var first = Registry.get_value("value", strings[index]) if Registry.get_registry("value").has(strings[index]) else Registry.get_value("constant", strings[index])
		var second = Registry.get_value("value", strings[index + 1]) if Registry.get_registry("value").has(strings[index + 1]) else Registry.get_value("constant", strings[index + 1])
	
		var delim = delims[index]
		var initial_compare = calculate_result_initial(first, second ,delim)

		var compared = calculate_result(result, second, delim)
		result = initial_compare if index == 0 else compared
	return result
