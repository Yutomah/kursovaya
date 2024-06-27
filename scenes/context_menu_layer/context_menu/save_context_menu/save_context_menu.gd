extends ContextMenu
class_name SaveContextMenu


func _on_save_button_pressed():
	if $VBoxContainer/LineEdit.text != "":
		GB.loader.save_blocks(GB.loader.serialize(), $VBoxContainer/LineEdit.text)
		close_context_menu()
