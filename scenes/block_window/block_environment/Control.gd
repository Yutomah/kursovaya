extends Control

var LKM_pressed:bool = false
var old_mouse_position:Vector2
@export var camera:Camera2D
var context_menu = preload("res://scenes/context_menu_layer/context_menu\
/block_field_context_menu/block_field_context_menu.tscn")

func _process(_delta):
	if LKM_pressed:
		camera.offset += old_mouse_position - camera.get_global_mouse_position()
		
func _on_mouse_entered():
	grab_focus()

func _on_gui_input(event):
	if event.is_action_pressed("LKM") and GB.current_tool == GB.HAND_TOOL:
		LKM_pressed = true
		old_mouse_position = camera.get_global_mouse_position()
		
	if event.is_action_pressed("RKM"):
		open_context_menu()

func _input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		LKM_pressed = false

func open_context_menu():
	var menu := context_menu.instantiate() as BlockFieldContextMenu
	menu.block_schema = %GBlockSchema
	GB.context_menu_open_wanted.emit(menu)
	
