extends Control




func _on_name_label_gui_input(event):
	if event.is_action_pressed("LKM") and event.double_click:
		$NameLabel.hide()
		$NameLineEdit.show()
