extends Button


func _ready():
	GB.stop_all_blocks_wanted.connect(func(): text = "pause")
	
func _on_pressed():
	if(GB.paused):
		GB.continue_all_blocks_wanted.emit()
		GB.paused = false
		text = "pause"
	else:
		GB.paused = true
		text = "continue"
		
