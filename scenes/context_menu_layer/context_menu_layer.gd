extends Control

func _ready():
	GB.context_menu_open_wanted.connect(on_context_menu_open_wanted)
	
func on_context_menu_open_wanted(context_menu:ContextMenu):
	add_child(context_menu)
	
	if context_menu is SaveContextMenu or context_menu is LoadContextMenu:
		pass
	else:
		context_menu.anchors_preset = 0
		context_menu.position = get_local_mouse_position()
	
	
