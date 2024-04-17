extends Control

@onready var g_block = $"../../../.."
		
func _ready():
	$NameLabel.text = $"../Type".text
	g_block.block_name = $NameLabel.text
	
func _on_name_label_gui_input(event):
	if event.is_action_pressed("LKM") and event.double_click:
		$NameLabel.hide()
		$NameLineEdit.text = $NameLabel.text
		$NameLineEdit.grab_focus()
		$NameLineEdit.show()


func _on_name_line_edit_focus_exited():
	if !$NameLineEdit.get_rect().has_point(get_local_mouse_position()):
		$NameLabel.text = $NameLineEdit.text
		g_block.block_name = $NameLabel.text
		GB.block_name_changed.emit()
		$"../../..".grab_focus()
		$NameLabel.show()
		$NameLineEdit.hide()
	


func _on_name_line_edit_text_submitted(new_text):
	$NameLabel.text = $NameLineEdit.text
	g_block.block_name = $NameLabel.text
	GB.block_name_changed.emit()
	$NameLabel.show()
	$NameLineEdit.hide()

	
