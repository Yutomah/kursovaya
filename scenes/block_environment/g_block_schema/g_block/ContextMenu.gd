extends MarginContainer


@onready var block:GBlock = get_parent()

func _input(event):
	if (event.is_action_pressed("LKM") or event.is_action_pressed("RKM")):
		if visible and !get_rect().has_point(get_parent().get_local_mouse_position()):
			close_context_menu()

func _on_delete_button_pressed():
	block.remove_myself()

func close_context_menu():
	hide()


