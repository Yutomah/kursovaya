extends ContextMenu
class_name BlockContextMenu

var block:GBlock = null

func _on_delete_button_pressed():
	PSM.process_input(PSM.INPUT.STOP)
	block.remove_myself()
	queue_free()

