extends Button


func _ready():
	PSM.state_changed.connect(on_state_changed)
	
func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			text = "pause"
			disabled = false
		PSM.STATE.PAUSE:
			text = "continue"
			disabled = false
		PSM.STATE.STOP:
			text = "pause"
			disabled = true
		PSM.STATE.CLEAR:
			text = "pause"
			disabled = true
		
func _on_pressed():
	PSM.process_input(PSM.INPUT.PAUSE_CONTINUE)
	
		
