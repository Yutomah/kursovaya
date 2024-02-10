extends Node2D
class_name GBlock

var LKM_pressed:bool = false
var old_mouse_position:Vector2
var class_type:String = "Базовый блок"

func _ready():
	$Control/Content/Type.text = class_type
	
func _process(delta):
	if LKM_pressed:
		var dif = get_local_mouse_position() - old_mouse_position
		position += dif
		
		for begin_point in $BeginPoints.get_children():
			begin_point.update_static_line_pos()
		
		for end_point in $EndPoints.get_children():
			if end_point.begin_point != null:
				end_point.begin_point.update_static_line_pos()
				
func _on_control_mouse_entered():
	$Control.grab_focus()


func _on_control_gui_input(event):
	if event.is_action_pressed("LKM") and GB.current_tool == GB.SELECTION_TOOL:
		LKM_pressed = true
		old_mouse_position = get_local_mouse_position()
		$Control.accept_event()
		
func _input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		LKM_pressed = false
