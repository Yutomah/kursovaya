extends Button

func _ready():
	PSM.state_changed.connect(on_state_changed)
	
func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			#icon = load("res://Sprites/magnifying_glass/return.png")
			icon = load("res://Sprites/player_icons/play-button-arrowhead (1) копия.png")
		PSM.STATE.PAUSE:
			icon = load("res://Sprites/player_icons/play-button-arrowhead (1) копия.png")
		PSM.STATE.STOP:
			icon = load("res://Sprites/player_icons/play-button-arrowhead (1) копия.png")
		PSM.STATE.CLEAR:
			icon = load("res://Sprites/player_icons/play-button-arrowhead (1) копия.png")
	pass
		
func _on_pressed():
	PSM.process_input(PSM.INPUT.PLAY)
	
		
