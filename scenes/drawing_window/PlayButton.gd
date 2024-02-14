extends Button


func _on_pressed():
	GB.activate_all_begin_blocks_wanted.emit()
