@tool
extends Node2D

var type = "test"
var dragging = false
var connected := {} as Dictionary
var id = ""
var line_texture = NinePatchRect.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	id = StringHelper.gen_uuid(32, type)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drag()
	draw_flow_line()
	update()
	pass
	
func update():
	if EditorGlobals.flow_held_by_mouse != self && connected.size() <= 0:
		if dragging:
			dragging = false
		get_node("Texture/NinePatchRect").visible = false
	else:
		get_node("Texture/NinePatchRect").visible = true
	pass
func draw_flow_line():
	#print(connected)
	var do_update = (dragging || connected.size() > 0) || Engine.is_editor_hint()
	get_node("Texture/NinePatchRect").visible = do_update
	get_node("Texture/NinePatchRect").position.y = get_node("Texture/NinePatchRect").size.x / 2
	if do_update && !Engine.is_editor_hint():
		if dragging:
			get_node("Texture").look_at(get_global_mouse_position())
			get_node("Texture/NinePatchRect").size.y = get_global_mouse_position().distance_to(get_node("Texture/NinePatchRect").global_position) + 8
		else:
			get_node("Texture").look_at(connected.values()[0].position)
			get_node("Texture/NinePatchRect").size.y = connected.values()[0].position.distance_to(get_node("Texture/NinePatchRect").global_position) + 8
		

	pass

func drag():
	var hovered_or_held = EditorGlobals.flow_hovered_by_mouse == self || EditorGlobals.flow_held_by_mouse == self
	if hovered_or_held:
		if (EditorGlobals.left_mouse):
			dragging = true
			if EditorGlobals.flow_held_by_mouse == null:
				EditorGlobals.flow_held_by_mouse = self
		else:
			dragging = false
			EditorGlobals.flow_held_by_mouse = null
			drop()
	pass

func drop():
	if EditorGlobals.second_flow_hovered_by_mouse != null:
		connected[EditorGlobals.second_flow_hovered_by_mouse.id] = EditorGlobals.second_flow_hovered_by_mouse
	pass

func _on_area_2d_mouse_shape_entered(shape_idx):
	if EditorGlobals.flow_held_by_mouse == null:
		EditorGlobals.flow_hovered_by_mouse = self
	else:
		print("f")
		EditorGlobals.second_flow_hovered_by_mouse = self
			
	pass # Replace with function body.


func _on_area_2d_mouse_shape_exited(shape_idx):
	
	if EditorGlobals.second_flow_hovered_by_mouse == self:
		EditorGlobals.second_flow_hovered_by_mouse = null
		EditorGlobals.flow_hovered_by_mouse = null
	else:
		EditorGlobals.flow_hovered_by_mouse = null
	pass # Replace with function body.
