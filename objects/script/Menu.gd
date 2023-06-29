extends GridContainer

var menu_name = "null"
var pos = Vector2.ZERO
var selected_name = ""
var selected_index = 0
var index_x = 0
var index_y = 0
var nav_cooldown = 0
var skip_cooldown = 0
var entries = {}
var column_count = 0
var row_count = 0
var remove_test = false
var prev_pressed = "none"
var removed_names = []

func _ready():
	pass

func init(menu_name: String, x, y, column_count: int = 1):
	self.menu_name = menu_name
	self.column_count = column_count
	columns = column_count
	pos = Vector2(x, y)
	pass
func _process(delta):
	visible = GenericVariables.current_menu == menu_name
	global_position = pos
	var moduloed = (get_child_count() + get_child_count() % column_count) if get_child_count() > 0 else 0
	row_count = moduloed / 2 if moduloed > 0 else get_child_count() / column_count if moduloed > 0 else 0

	if (get_child_count()  > 0):
		if (GenericVariables.current_menu == menu_name):
			navigate()
			if (get_selected() != null):
				GenericVariables.current_menu_selection = get_selected().entry_name

		for child in get_children():
			if (child != null && get_selected() != null ):
				if removed_names.has(child.entry_name):
					child.visible = false
				child.modulate = Color(0.5,0.5,0.5,1.0) if child.entry_name != get_selected().entry_name else Color(1.0,1.0,1.0,1.0)

	pass
func get_entry(entry_name: String):
	var result = get_child(0)
	for child in get_children():
		if child.entry_name == entry_name:
			result = child
			break
	return result
func get_selected():
	return get_child(selected_index)
func navigate():
	var u = Input.is_key_pressed(KEY_UP)
	var d = Input.is_key_pressed(KEY_DOWN)
	var l = Input.is_key_pressed(KEY_LEFT)
	var r = Input.is_key_pressed(KEY_RIGHT)
	var no_input = !(u || d || l || r)
	if (nav_cooldown <= 0):
		if (u):
			var idx = get_wrapped_index("up")
			var b = get_child(idx) != null
			var back_offset = 1 if prev_pressed == "left" else 2 if prev_pressed == "down" else 0

			selected_index = idx 

			nav_cooldown = 4
		elif (d):
			var idx = get_wrapped_index("down")
			var b = get_child(idx) != null
			var back_offset = 1 if prev_pressed == "left" else 2 if prev_pressed == "down" else 0

			selected_index = idx
			
			nav_cooldown = 4
		elif (l):
			var idx = get_wrapped_index("left")
			var b = get_child(idx) != null
			var back_offset = 1 if prev_pressed == "left" else 2 if prev_pressed == "down" else 0
			selected_index = idx
			nav_cooldown = 4
		elif (r):
			var idx = get_wrapped_index("right")
			var b = get_child(idx) != null
			var back_offset = 1 if prev_pressed == "left" else 2 if prev_pressed == "down" else 0
			selected_index = idx
			nav_cooldown = 4
	if (nav_cooldown > 0):
		nav_cooldown -= 1
	if (no_input):
		nav_cooldown = 0
	pass
func get_wrapped_index(direction: String):
	var result = 0
	var b = index_x + (index_y * column_count) < get_child_count()
		

	if (direction == "up" ):
		prev_pressed = "up"
		index_y = clamp(index_y - 1, 0, row_count - 1)
	elif (direction == "down"):
		prev_pressed = "down"
		index_y = clamp(index_y + 1, 0, row_count - 1)
	elif (direction == "left"):
		prev_pressed = "left"
		index_x = clamp(index_x - 1, 0, column_count  - 1)
	elif (direction == "right"):
		prev_pressed = "right"
		index_x =  clamp(index_x + 1, 0, column_count - 1) 
	return index_x + (index_y * column_count)

