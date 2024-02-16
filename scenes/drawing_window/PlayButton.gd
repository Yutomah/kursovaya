extends Button

func _ready():
	PSM.state_changed.connect(on_state_changed)
	
func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			text = "replay"
		PSM.STATE.PAUSE:
			text = "replay"
		PSM.STATE.STOP:
			text = "play"
		PSM.STATE.CLEAR:
			text = "play"
		
func _on_pressed():
	PSM.process_input(PSM.INPUT.PLAY)
	
		
