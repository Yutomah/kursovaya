extends Button


func _on_pressed():
	GB.change_drawing_window_vision.emit()
