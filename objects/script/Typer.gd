extends Node2D

var pos = Vector2(0,0)
var current_width = 0
var queued_text = ""
var type_delay = 0
var cursor_index = -1
var string_size = 0
var time = 0
var typer_delay = 2
var line = 0
var clear_no_pos = false
var clear_pos = false
var hard_clear = false
var reset_pos = false
var soft_typing_check = false
var insta_type = false
var text_style = "text_box"
var skipping = false
var clear_cooldown = 1
var stop = false
var next_modifier = false

#Modifier Vars
var event_modifier = false
var modifier_delay = 0
var delay_string = ""
var padding_string = ""
var delay_modifier = false
var x_string = ""
var y_string = ""
var y_modifier = false
var x_modifier = false
var line_break_modifier = false
var padding_modifier = false
var delay_modified = false
var padding_modified = false
var x_modified = false
var y_modified = false
var modified_y_pos = 0
var modified_x_pos = 0
var modified_padding = 0
var clear_modifier = false
var bracket_mode = false
var has_text_bubble = true
var typed_length = 0


const reference_letter = preload("res://objects/TyperLetter.tscn")

func _ready():


	pass

func new_letter(provided_letter):
	var next_letter = reference_letter.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	next_letter.init(provided_letter,Vector2(current_width, 32 * line), text_style)
	current_width = current_width + (next_letter.padding + 1)
	add_child.call_deferred(next_letter)

	pass

func type(provided_text, use_bubble: bool = false, clear: bool = false):
	soft_typing_check = true
	queued_text = provided_text;
	string_size = provided_text.length()
	cursor_index = -1
	current_width = 0
	line = 0
	clear_cooldown = 4
	clear_pos = clear
	has_text_bubble = use_bubble
	for char in provided_text:
		typed_length += Util.get_letter_padding(char, text_style)

func display_text(provided_text):
	clear_pos = true
	
	for index in provided_text:
		new_letter(index)
	current_width = 0	
	check_clear()

	



func tick_display():
	var bubble = get_node("TextBubble")
	if insta_type:

		for index in queued_text:
			new_letter(index)

	elif is_typing():

		new_letter(letter_at_cursor())
	elif !bracket_mode:
		parse_bracket_string()
	if bubble != null:
		bubble.visible = has_text_bubble
		if (has_text_bubble):
			bubble.size_x = current_width + 16
			bubble.size_y = 32 + (32 * line)
			bubble.position = Vector2(-16, -12 - (32 * line))
	pass

func is_typing():
	return !(!is_delayed() && !is_start_bracket() && !bracket_mode && soft_typing_check)

func tick():
	check_clear()
	tick_with_delays()
	pass

func clear():
	clear_pos = true
	pass

func check_clear():
	if clear_pos || clear_no_pos || hard_clear:
		cursor_index = -1
		clear_children()
		clear_no_pos = false
	if reset_pos || clear_pos || hard_clear:
		pos = Vector2.ZERO
		modified_x_pos = 0
		modified_y_pos = 0
		reset_pos = false
		if clear_pos:
			clear_pos = false
	if hard_clear:
		queued_text = ""
		hard_clear = false
	pass

func clear_children():
	for child in get_children():
		child.queue_free()

func tick_with_delays():
	var d_type = is_delayed(true)
	if !is_delayed():
		cursor_index += 1
		type_delay = typer_delay
		tick_display()
	elif d_type == "type":
		type_delay -= 1
	elif d_type == "mod":
		modifier_delay -= 1
	else:
		print("Invalid Delay Type. This Shouldn't Happen")

func is_delayed(type_mode: bool = false):
	var type_del = type_delay > 0
	var mod_del = modifier_delay > 0
	if type_mode:
		if (type_del && !mod_del):
			return "type"
		elif (mod_del):
			return "mod"
		else:
			return "invalid"
	else:
		return type_del || mod_del

func is_start_bracket():
	return letter_at_cursor() == "["

func is_end_bracket(text):
	return text == "]"

func letter_at_cursor():
	return queued_text[cursor_index]

func _process(_delta):
	if (cursor_index < queued_text.length() - 1):
		tick()
	pass

func parse_bracket_string():
	bracket_mode = true
	reset_modifiers()
	for index in queued_text:
		if !is_end_bracket(index):
			read_modifiers(index)
		else:
			break
	bracket_mode = false
		
# Bracket Modifier Instructions

# No Special Sub-Mode
		# , = next modifier
		# d = delay
		# c = clear current dialogue
		# x = add to cursor x position
		# y = add to cursor y position
		# b = line break
		# i = indent
		# p = padding 
		# ! = event
		# e = end of all dialogue

# Clear Mode
		# h = clear current queued text + effect of c
		# p = position reset
		# s = clear letters and keep position
		# c = clear letters and reset position

func read_modifiers(text):
	if (x_modifier && !x_modified):
		modified_x_pos += int(x_string)
		x_modified = true
		x_string = ""
	if (y_modifier && !y_modified):
		modified_y_pos += int(y_string)
		y_modified = true
		y_string = ""
	if (delay_modifier):
		modifier_delay = int(delay_string)
		delay_modified = true
		delay_string = ""
	if (clear_modifier):
		clear_modifier = false
	if (padding_modifier):
		modified_padding = int(padding_string)
		padding_modified = true
		padding_string = ""
	if (text == ","):
		if (x_modifier && !x_modified):
			modified_x_pos += int(x_string)
			x_modified = true
			x_string = ""
		if (y_modifier && !y_modified):
			modified_y_pos += int(y_string)
			y_modified = true
			y_string = ""
		if (delay_modifier):
			modifier_delay = int(delay_string)
			delay_modified = true
			delay_string = ""
		if (padding_modifier):
			modified_padding = int(padding_string)
			padding_modified = true
			padding_string = ""	
		reset_modifiers()
	if (!event_modifier && !clear_modifier):
		if (text == "i"):
			line = line - 1
		if (text == "i"):
			line = line - 1
		if (text == "y"):
			y_modifier = true
			y_modified = false
		if (text == "x"):
			x_modifier = true
			x_modified = false
		if (text == "d"):
			delay_modifier = true
			delay_modified = false
		if (text == "p"):
			padding_modifier = true
			padding_modified = false
		if (text == "c"):
			clear_modifier = true

		if (text == "b"):
			line = line - 1
			current_width = 0
			line_break_modifier = false
	if (text == "("):
		event_modifier = true
	if (text == ")"):
		event_modifier = false
	if (clear_modifier):
		if text == "h":
			hard_clear = true
		if text == "p":
			reset_pos = true
		if text == "s":
			clear_no_pos = true
		if text == "c":
			clear_pos = true
		clear_modifier = false
	if (padding_modifier):
		padding_string = padding_string.replace("p", "") + text
	if (delay_modifier):
		delay_string = delay_string.replace("d", "") + text
	if (x_modifier):
		x_string = x_string.replace("x", "") + text
	if (y_modifier):
		y_string = y_string.replace("y", "") + text
	pass
func reset_modifiers():
	delay_modifier = false	
	line_break_modifier = false
	padding_modifier = false
	x_modifier = false
	y_modifier = false
	if (line_break_modifier):
		line += 1
		line_break_modifier = false

	pass

