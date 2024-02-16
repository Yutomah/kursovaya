extends Button


func _ready():
	GB.stop_all_blocks_wanted.connect(func(): text = "pause")

func _process(_delta):
	if !GB.running:
		disabled = true
	else:
		disabled = false
		
func _on_pressed():
	if(GB.paused):
		GB.paused = false
		GB.continue_all_blocks_wanted.emit()
		text = "pause"
	else:
		GB.paused = true
		text = "continue"
		
