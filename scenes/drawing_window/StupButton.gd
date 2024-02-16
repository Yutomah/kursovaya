extends Button

func _process(_delta):
	if !GB.running:
		disabled = true
	else:
		disabled = false
		
func _on_pressed():
	GB.running = false
	GB.paused = false
	GB.stop_all_blocks_wanted.emit()
	
