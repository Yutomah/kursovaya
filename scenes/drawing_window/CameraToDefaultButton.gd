extends Button



func _on_pressed():
	GB.camera_to_default_wanted.emit()
