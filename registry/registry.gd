extends Node

var registries = {}

# A Dynamic Registry
# Register a type like this
# register(registry_name, reference_string, thing_to_register)
# a type has to exist beforehand to actually register something
# See other registry scripts for how to do this


# Attempt to read the givin folder name within that data folder
func read_folder(folder):
	var dir = DirAccess
	var exported = OS.has_feature("editor")
	var path = "res://data/" if exported else OS.get_executable_path().get_base_dir() + "/data/"
	path = path + folder + "/"
	var files = dir.open(path).get_files()
	var paths = {}
	for file in files:
		var id = str(file).replace(".json", "")
		paths.merge({id: path + file})
	return paths
func load_json(path):
	var loaded = load(path)
	var file = FileAccess.open(path, FileAccess.READ)
	return file.get_as_text()
func register(r, k, v):
	registries[r][k] = v
func add_assembled_registry(r, v):
	registries[r] = v
func get_registry(r):
	return registries[r]
func get_value(r, k):
	return registries[r][k]
