extends Control

var LKM_pressed:bool = false
var old_mouse_position:Vector2
@export var camera:Camera2D
@onready var context_menu = $"../../../ContextMenu"
func _process(delta):
	if LKM_pressed:
		camera.offset += old_mouse_position - camera.get_global_mouse_position()
		
func _on_mouse_entered():
	grab_focus()
	print(1)

func _on_gui_input(event):
	
	print(2)
	if event.is_action_pressed("LKM") and GB.current_tool == GB.HAND_TOOL:
		LKM_pressed = true
		old_mouse_position = camera.get_global_mouse_position()
		
	if event.is_action_pressed("RKM"):
		context_menu.global_position = context_menu.get_global_mouse_position()
		$"../../../ContextMenu".show()

func _input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		LKM_pressed = false
