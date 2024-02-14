extends Button


func _on_pressed():
	GB.stop_all_blocks_wanted.emit()
	GB.running = false
	GB.paused = false
