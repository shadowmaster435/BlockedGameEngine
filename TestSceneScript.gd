extends Node

var debug_mode = "dialogue,player";

@onready var player_variables = get_node("/root/PlayerVariables")
@onready var player_functions = get_node("/root/PlayerVariables")
@onready var battle_variables = get_node("/root/PlayerVariables")
@onready var battle_functions = get_node("/root/PlayerVariables")
@onready var generic_variables = get_node("/root/PlayerVariables")
@onready var generic_functions = get_node("/root/PlayerVariables")
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
