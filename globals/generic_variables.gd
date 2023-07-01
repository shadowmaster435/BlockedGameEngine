extends Node
@onready var main = get_node("/root/Main")
@onready var functions = get_node("/root/GenericFunctions")
var tracked_variables = {}

var current_menu = "none"
var current_menu_selection = "none"
var timer = 0
