extends Button


func _on_pressed():
	GB.stop_all_blocks_wanted.emit()
	GB.running = false
	GB.paused = false
	
	GB.clear_field_wanted.emit()
	GB.activate_all_begin_blocks_wanted.emit()
	GB.running = true
