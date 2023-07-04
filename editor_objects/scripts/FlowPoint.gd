@tool
extends Node2D

var type = "test"
var dragging = false
var flow_lines = {}
var queued_line = null
const line_ref = preload("res://editor_objects/FlowLine.tscn")

func _process(delta):
	drag()
	if !Engine.is_editor_hint() && flow_lines.size() >0 && flow_lines.keys().has(flow_lines.values()[0].id):
		print(flow_lines)
	update()
func update():
	if EditorGlobals.flow_held_by_mouse != self && flow_lines.size() <= 0:
		if dragging:
			dragging = false
	type = get_parent().type
func new_line():
	var obj = line_ref.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	obj.init(self)
	add_child(obj)
	queued_line = obj
func drag():
	var hovered_or_held = EditorGlobals.flow_hovered_by_mouse == self || EditorGlobals.flow_held_by_mouse == self
	if hovered_or_held:
		if (EditorGlobals.left_mouse):
			if queued_line == null:
				new_line()
			dragging = true
			if EditorGlobals.flow_held_by_mouse == null:
				EditorGlobals.flow_held_by_mouse = self
		else:
			dragging = false
			drop()
			EditorGlobals.flow_held_by_mouse = null
func drop():
	if EditorGlobals.second_flow_hovered_by_mouse != null:
		flow_lines[queued_line.id + "|" + queued_line.get_connect_type()] = queued_line
		EditorGlobals.second_flow_hovered_by_mouse.flow_lines[EditorGlobals.second_flow_hovered_by_mouse.flow_lines.id + "|" + queued_line.get_connect_type()] = queued_line
		queued_line.link()
		queued_line = null
func _on_area_2d_mouse_shape_entered(shape_idx):
	if EditorGlobals.flow_held_by_mouse == null:
		EditorGlobals.flow_hovered_by_mouse = self
	else:
		EditorGlobals.second_flow_hovered_by_mouse = self
func _on_area_2d_mouse_shape_exited(shape_idx):
	if EditorGlobals.second_flow_hovered_by_mouse == self:
		EditorGlobals.second_flow_hovered_by_mouse = null
		EditorGlobals.flow_hovered_by_mouse = null
	else:
		EditorGlobals.flow_hovered_by_mouse = null
