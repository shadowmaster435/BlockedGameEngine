extends Node2D

@onready var rect = get_node("NinePatchRect")
var passthru_types = [
	"or", "and", "not", "nor", "nand", "pass_through"
]
var type = "any_dir"
var start_node = null
var end_node = null
var id = ""
var anim_time = 0
var anim_frame = 0
func _ready():
	id = StringHelper.gen_uuid(32, type)
func is_linked() -> bool:
	var result = false
	if nodes_not_null():
		if start_node.flow_lines.values().has(self) && end_node.flow_lines.values().has(self):
			result = true
	return result
func nodes_not_null():
	return start_node != null && end_node != null
func init(start):
	start_node = start
func link():
	if EditorGlobals.second_flow_hovered_by_mouse != null:
		end_node = EditorGlobals.second_flow_hovered_by_mouse
	else:
		queue_free()
func unlink(node):
	if node == end_node:
		start_node = end_node
	end_node = null
func either_dragging():
	var start_null_check = false if start_node == null else start_node.dragging
	var end_null_check = false if end_node == null else end_node.dragging
	return start_null_check || end_null_check
func start_pos() -> Vector2:
	return Vector2.ZERO if start_node == null else start_node.position
func end_pos() -> Vector2:
	return Vector2.ZERO if end_node == null else end_node.position
func mouse_pos():
	return get_global_mouse_position()
func length(use_mouse: bool):
	return start_pos().distance_to(end_pos()) + 12 if !use_mouse else start_pos().distance_to(mouse_pos()) + 12
func update():
	visible = either_dragging() || is_linked()
	if !is_linked() && either_dragging():
		rect.visible = true
		rect.size.y = length(true)
		look_at(mouse_pos())
	elif is_linked() && !either_dragging():
		rect.visible = true
		rect.size.y = length(false)
		look_at(end_pos())
	rect.visible = true
	animate_on_hover()
func _process(delta):
	update()
func animate_on_hover():
	anim_time = anim_time + 1 if anim_time < 2 else 0

	if anim_time == 0:
		if anim_frame < 3:
			anim_frame += 1
		else:
			anim_frame = 0
	var path = load("res://textures/ui/flow/animated_flow/frame_" + str(anim_frame) + ".png")
	rect.texture = path
func get_connect_type():
	var result = ""
	var hover_type = EditorGlobals.second_flow_hovered_by_mouse.type
	if start_node != null && hover_type != null:
		var og_type = start_node.type
		var cond_and_action = Util.equal_swapped(og_type, hover_type, "condition", "action")
		var cond_and_cond = Util.both_equal(og_type, hover_type, "condition")
		var action_and_action = Util.both_equal(og_type, hover_type, "action")
		var cond_and_passthru = Util.equal_swapped(og_type, hover_type, "condition", "pass_through")
		var action_and_passthru = passthru_types.has(og_type) && hover_type == "action" || passthru_types.has(hover_type) && og_type == "action"
		var passthru_and_passthru = passthru_types.has(og_type) && passthru_types.has(hover_type)
		if cond_and_action:
			result = "if_then"
		elif cond_and_passthru || passthru_and_passthru || action_and_passthru:
			result = get_type_with_passthru()
		elif cond_and_cond || action_and_action:
			result = "none"
	else:
		result = "none"
	return result

func get_type_with_passthru():
	var result = ""
	var hover_type = EditorGlobals.second_flow_hovered_by_mouse.type
	var og_type = start_node.type
	var both_passthru = Util.both_equal(og_type, hover_type, "pass_through")
	var cond_passthru = hover_type != og_type && (og_type == "condition" && hover_type == "pass_through") || (hover_type == "condition" && og_type == "pass_through")
	var both_cond_mod = !Util.both_equal_excluding(og_type, hover_type, "pass_through", passthru_types)
	var cond_mod_and_action = Util.both_equal_excluding(og_type, hover_type, "pass_through", passthru_types + ["action"])
	if both_passthru:
		result = "pass_through"
	elif cond_passthru:
		result = "cond_pass_through"
	elif both_cond_mod:
		result = "cond_mod"
	elif cond_mod_and_action:
		result = "action_check"
	return result
