extends Node2D

func _ready():
	GB.current_tool = GB.SELECTION_TOOL

func _input(event):
	if event is InputEventKey and event.keycode == KEY_H and event.is_pressed():
		GB.current_tool = GB.HAND_TOOL
	if event is InputEventKey and event.keycode == KEY_V and event.is_pressed():
		GB.current_tool = GB.SELECTION_TOOL
