extends Node2D

func _ready():
	pass
	#get_viewport().gui_focus_changed.connect(func(node): print("outside ",node))

func _input(event):
	if event.is_action_pressed("LKM"):
		print(GB.focus_window, GB.current_tool)
	
	

