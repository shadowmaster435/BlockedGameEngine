extends Node


func parse(original_root, curr, prev: Object = null):
	
	if prev == null:
		for flow_line in curr.original_root:
			var connect_type = connect_type(flow_line.id)
			
	pass
func connect_type(id_string: String):
	return id_string.get_slice("|", 2)
func flow_type(id_string):
	return id_string.get_slice("|", 1)

func parse_with_type(type: String):
	var if_then = type == "if_then"
	pass
func get_passthrough_type():
	pass

func condition():
	pass
