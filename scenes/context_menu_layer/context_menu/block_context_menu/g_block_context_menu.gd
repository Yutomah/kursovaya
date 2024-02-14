extends ContextMenu
class_name BlockContextMenu

var block:GBlock = null

func _on_delete_button_pressed():
	block.remove_myself()
	queue_free()

