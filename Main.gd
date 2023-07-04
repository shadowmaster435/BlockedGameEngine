extends Node
var registry_finished = false
var debug_mode = ""
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

var registry_printed = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	registry_finished = ConditionRegistry.finished && OperationRegistry.finished && SpriteRegistry.finished && ValueRegistry.finished && AnimationRegistry.finished
	
	if registry_finished:
		print(OperationParser.calculate("example"))

	if OS.has_feature("editor"):
		write_debug_files()

func write_debug_files():
	if !registry_printed && registry_finished && debug_mode.contains("registry"):
		registry_printed = true
		FileHelper.write_debug_registry_json(JSON.stringify(Registry.registries, "\t"))
	pass
