extends MarginContainer


@onready var block:GBlock = get_parent()
func _ready():
	GB.context_menu_close_wanted.connect(on_context_menu_close_wanted)
func _input(event):
	if (event.is_action_pressed("LKM") or event.is_action_pressed("RKM")):
		if visible and !get_rect().has_point(get_parent().get_local_mouse_position()):
			close_context_menu()

func _on_delete_button_pressed():
	block.remove_myself()

func on_context_menu_close_wanted():
	if visible and !get_rect().has_point(get_parent().get_local_mouse_position()) and has_focus():
		close_context_menu()
func close_context_menu():
	hide()


