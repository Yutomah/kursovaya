extends Button

func _process(_delta):
	if GB.running:
		text = "replay"
	else:
		text = "play"
		
func _on_pressed():
	GB.running = false
	GB.paused = false
	GB.stop_all_blocks_wanted.emit()
	
	
	GB.clear_field_wanted.emit()
	GB.running = true
	GB.activate_all_begin_blocks_wanted.emit()
	
		
