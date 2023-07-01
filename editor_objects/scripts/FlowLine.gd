extends Node2D

@onready var rect = get_node("NinePatchRect")

var type = "test"
var start_node = null
var end_node = null
var id = ""

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
func _process(delta):
	update()
