@tool
extends Node2D



@onready var typer = get_node("NinePatchRect/Typer")
@onready var rect = get_node("NinePatchRect")
@onready var area_shape = get_node("ClickArea/ClickShape")
@onready var area = get_node("ClickArea")
var tab_name = "foobar"
var active = false
var editor_state = null

func _ready():
	editor_state = StateHelper.create_state(self)

func _process(delta):
	update()
	update_display()

func update():
	active = EditorGlobals.active_tab == tab_name
	area.position.y = rect.size.y - (rect.size.y - 6)
	area.position.x = rect.size.x / 2 - 10
	area_shape.shape.size = rect.size

func update_display():
	var active_path = load("res://textures/ui/editor/editor_tab.png")
	var inactive_path = load("res://textures/ui/editor/editor_tab_inactive.png")
	typer.display_text("foobar")
	rect.size.x = typer.current_width + 24
	rect.texture = active_path if active else inactive_path

func check_click():
	if EditorGlobals.left_mouse && EditorGlobals.hovered_tab == tab_name && !active:
		EditorGlobals.active_tab = tab_name
		
func _on_click_area_mouse_entered():
	if EditorGlobals.hovered_tab == "":
		EditorGlobals.hovered_tab = tab_name

func _on_click_area_mouse_exited():
	if EditorGlobals.hovered_tab == tab_name:
		EditorGlobals.hovered_tab = ""
