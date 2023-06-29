extends CenterContainer

var entry_name = "null"
var padding = Vector2.ZERO
var event = {}
var textures = {}
var sprite = null


func init(entry_name: String, event: Dictionary, x_padding: int = 16, y_padding: int = 16, textures: Dictionary = {}):
	self.entry_name = entry_name
	var id_removed = entry_name.substr(0, entry_name.find(":"))
	if (textures.size() <= 0):
		get_node("Typer").display_text(id_removed)
	else:
		self.textures = textures
	self.event = event
	padding = Vector2(x_padding, y_padding)
	if (get_parent() != null):	
		get_parent().entry_names[entry_name] = self
	pass

func _ready():
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	custom_minimum_size = padding
	if textures.size() > 0:
		sprite = Sprite2D.new()
		if GenericVariables.current_menu_selection == entry_name && textures.has("highlighted"):
			sprite.set_texture(textures["highlighted"])
		else:
			sprite.set_texture(textures["default"])
	pass
