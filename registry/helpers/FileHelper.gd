extends Node


func write_debug_registry_json(string: String):
	var file = FileAccess.open("res://debug_out/registry.json", FileAccess.WRITE)
	file.store_string(string)
	file.close()

func write_json(string: String, path: String, file_name: String):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(string)
	file.close()
