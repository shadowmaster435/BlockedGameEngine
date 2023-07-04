@tool
extends Node2D

var connected_point = null
var connected_block = null
var queued_point = null
var disconnected = false
var flow_lines = {}
var root_pos = Vector2(0, 0)
var enabled = true

func update_owner_pos():
	if connected_point != null && EditorGlobals.block_held_by_mouse != connected_point.owner:
		if owner.root != null:
			root_pos = owner.root.root_pos - Vector2(24, 2)
		if connected_point != null && !disconnected:
			if connected_point.name.contains("Top") || connected_point.name.contains("Inner"):
				connected_point.get_parent().position = root_pos + position 
	else:
		if EditorGlobals.block_held_by_mouse != owner && EditorGlobals.block_held_by_mouse != owner.root:
			check_unsnap()
func _process(delta):
	var self_enabled = (EditorGlobals.block_held_by_mouse == null) != (EditorGlobals.block_held_by_mouse == owner)
	get_node("SnapArea/SnapArea").debug_color = Color(0.25, 0.5, 0.25, 0.5) if self_enabled else Color(0.5, 0.25, 0.25, 0.5)
func snap():
	if should_snap() && queued_point.connected_point == null:
		var check_names = (name.contains("Bottom") && queued_point.name.contains("Top")) ||  (name.contains("Top") && queued_point.name.contains("Bottom"))
		if check_names:
			connected_point = queued_point
			if connected_point.connected_point == null:
				connected_point.connected_point = self
func check_unsnap():
	if connected_point != null:
		var check_names = (name.contains("Bottom") && connected_point.name.contains("Top")) ||  (name.contains("Top") && connected_point.name.contains("Bottom"))
		if check_names:
			connected_point = null
			owner.root_pos = Vector2.ZERO
			disconnected = true
	if disconnected && !EditorGlobals.left_mouse:
		disconnected = false
func snap_pos():
	return Vector2(0,0) if connected_point == null else connected_point.root_pos
func add_pos(pos: Vector2):
	return position + pos
func set_pos(pos: Vector2):
	position = pos
func should_snap():
	return can_snap(queued_point) && queued_point != null && queued_point.connected_point == null && owner.dragging && !EditorGlobals.left_mouse
func enable():
	enabled = true
func disable():
	enabled = false
func get_snap_point(area):
	if area.get_parent() != null:
		return area.get_parent() if area.get_parent().name.contains("Snap") else null
	else:
		return null
func can_snap(snap_point):
	return snap_point != null && snap_point.enabled && snap_point != self
func _on_snap_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if can_snap(get_snap_point(area)) && !disconnected:
		queued_point = get_snap_point(area)
func _on_snap_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if queued_point != null:
		queued_point = null
		disconnected = false
