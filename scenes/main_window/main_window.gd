extends Node2D

func _ready():
	get_viewport().gui_focus_changed.connect(func(node): print("outside ",node))
	





func _on_control_mouse_entered():
	GB.focus_window = GB.MAIN_WINDOW


