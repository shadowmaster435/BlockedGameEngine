@tool
extends Node2D

@onready var area_shape = get_node("NinePatchRect/ClickArea/AreaShape")
@onready var tex = get_node("NinePatchRect")
@onready var top = get_node("TopSnap")
@onready var bottom = get_node("BottomSnap")

var dragging = false
var is_root = false
var root_pos = Vector2(0, 0)
var root = null
var block_hover_offset = Vector2(0,0)
var block_hover_offset_set = false


func _process(delta):
	update_click_area()
	update_snap_points()
	drag()
	update()
func update():
	is_root = top.connected_point == null
	if is_root:
		root_pos = position
		bottom.owner.root_pos = position
		root = self
		bottom.owner.root = self
	else:
		root_pos = Vector2(0, 0)
		root = top.owner.root
		bottom.owner.root = root
		bottom.owner.root_pos = root.position
func drag():
	var hover_or_held = EditorGlobals.block_hovered_by_mouse == self || EditorGlobals.block_held_by_mouse == self
	area_shape.debug_color = Color(0.25, 0.5, 0.25, 0.5) if hover_or_held else Color(0.5, 0.25, 0.25, 0.5)
	if hover_or_held:
		if EditorGlobals.left_mouse:
			if !block_hover_offset_set:
				block_hover_offset = get_local_mouse_position()
				block_hover_offset_set = true
			position = get_global_mouse_position() - block_hover_offset
			EditorGlobals.block_held_by_mouse = self
			dragging = true
		else:
			EditorGlobals.block_held_by_mouse = null
			if dragging:
				drop()
			dragging = false
			block_hover_offset = Vector2(0, 0)
			block_hover_offset_set = false
func drop():
	top.snap()
	bottom.snap()
func update_click_area():
	area_shape.position = (area_shape.shape.size / 2) + Vector2(4, 4)
	area_shape.shape.size = Vector2(tex.size.x - 8, tex.size.y - 16)
	pass
func update_snap_points():
	bottom.position.y = area_shape.shape.size.y + 6
	bottom.position.x = 24
	top.position.x = 24
	top.position.y = 2
	top.update_owner_pos()
	bottom.update_owner_pos()
func _on_click_area_mouse_shape_entered(shape_idx):
	if get_node("/root/EditorGlobals").block_hovered_by_mouse == null && get_node("/root/EditorGlobals").block_held_by_mouse == null:
		get_node("/root/EditorGlobals").block_hovered_by_mouse = self
func _on_click_area_mouse_shape_exited(shape_idx):
	if get_node("/root/EditorGlobals").block_hovered_by_mouse == self:
		get_node("/root/EditorGlobals").block_hovered_by_mouse = null
