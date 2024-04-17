extends Button

var save_context_menu:PackedScene = preload("res://scenes/context_menu_layer/context_menu/save_context_menu/save_context_menu.tscn")
var loader:Loader
# Called when the node enters the scene tree for the first time.
func _ready():
	GB.loader_created.connect(func(x): loader = x)

func _on_pressed():
	var menu = save_context_menu.instantiate()
	menu.loader = loader
	GB.context_menu_open_wanted.emit(menu)
