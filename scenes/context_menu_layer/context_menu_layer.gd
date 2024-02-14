extends Control

func _ready():
	GB.context_menu_open_wanted.connect(on_context_menu_open_wanted)
	
func on_context_menu_open_wanted(context_menu:ContextMenu):
	context_menu.position = get_local_mouse_position()
	add_child(context_menu)
