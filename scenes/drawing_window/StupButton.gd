extends Button


func _ready():
	PSM.state_changed.connect(on_state_changed)
	
func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			disabled = false
		PSM.STATE.PAUSE:
			disabled = false
		PSM.STATE.STOP:
			disabled = true
		PSM.STATE.CLEAR:
			disabled = true
		
func _on_pressed():
	PSM.process_input(PSM.INPUT.STOP)
	
	
