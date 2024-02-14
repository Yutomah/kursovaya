extends Button

var paused:bool = false:
	set(value):
		if value == false:
			text = "pause"
		else:
			text = "continue"


func _on_pressed():
	if(paused):
		GB.continue_all_blocks_wanted.emit()
	else:
		GB.pause_all_blocks_wanted.emit()
	paused = !paused
	
		
