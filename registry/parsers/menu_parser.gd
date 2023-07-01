extends Node

const menu_ref = preload("res://objects/Menu.tscn")
const element_ref = preload("res://objects/MenuEntry.tscn")

func init_element(element_name: String, event: Dictionary, menu: GridContainer, x_padding: int = 16, y_padding: int = 16):
	var new_element = element_ref.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	new_element.init(element_name, event, x_padding, y_padding)
	menu.add_child(new_element)
func init_menu(menu_name: String, entries: Dictionary, x, y, columns: int = 1, x_padding: int = 16, y_padding: int = 16):
	var new_menu = menu_ref.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	new_menu.init(menu_name, x, y, columns)
	parse_elements(entries, new_menu, x_padding, y_padding)
	add_child.call_deferred(new_menu)
func parse_elements(elements: Dictionary, menu, x_padding: int = 16, y_padding: int = 16):
	for key in elements:
		init_element(key, elements[key], menu, x_padding, y_padding)
func parse_menu(menu: Dictionary, menu_name):
	if (menu.has("columns")):
		init_menu(menu_name, menu["entries"], menu["x"], menu["y"], menu["columns"], menu["horizontal_padding"], menu["vertical_padding"])
	else:
		init_menu(menu_name, menu["entries"], menu["x"], menu["y"])
