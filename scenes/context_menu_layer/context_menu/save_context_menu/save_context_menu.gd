extends ContextMenu
class_name SaveContextMenu

var loader:Loader

func _on_save_button_pressed():
	if $VBoxContainer/LineEdit.text != "":
		loader.save_blocks(loader.serialize(), $VBoxContainer/LineEdit.text)
		close_context_menu()
