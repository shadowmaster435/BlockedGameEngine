extends Node

func save_state(node: Node, id: String):
	var result = {}
	var packed = PackedScene.new()
	packed.pack(node)
	ResourceSaver.save(packed, "res://editor/editor_states/" + id + ".tscn")
	for child in node.get_children():

		result[child.name] = child.get_property_list()
	return node
func load_state(dict, root_node):
	for key in dict:
		var val = dict[key]
		var obj = JSON.parse_string(val)
		obj.name = key
		root_node.add_child(obj)

func create_state(node):
	var packed = PackedScene.new()
	packed.pack(node)
	return packed
