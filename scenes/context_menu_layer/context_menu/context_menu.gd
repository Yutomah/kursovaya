extends PanelContainer
class_name ContextMenu
	
func _input(event):
	if (event.is_action_pressed("LKM") or event.is_action_pressed("RKM")):
		if visible and !get_rect().has_point(get_parent().get_local_mouse_position()):
			close_context_menu()
	
func close_context_menu():
	queue_free()
