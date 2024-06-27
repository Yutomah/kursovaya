extends Button

var save_context_menu:PackedScene = preload("res://scenes/context_menu_layer/context_menu/save_context_menu/save_context_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_pressed():
	var menu = save_context_menu.instantiate()
	GB.context_menu_open_wanted.emit(menu)
