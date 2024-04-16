extends Node2D
class_name GEndPoint

@onready var block:GBlock = get_parent().get_parent()
var begin_point:GBeginPoint
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	draw_circle(Vector2.ZERO, 3, Color.WHEAT)


func remove_link():
	if begin_point!= null:
		begin_point.line.points[-1] = Vector2.ZERO
		begin_point.end_point = null
		begin_point = null

func _on_control_end_gui_input(event):
	if  event.is_action_pressed("LKM") and GB.current_tool == GB.SELECTION_TOOL:
		print("1")
		if begin_point != null:
			print("2")
			begin_point.LKM_pressed = true
			$ControlEnd.accept_event()


func _on_control_end_mouse_entered():
	$ControlEnd.grab_focus()
	



func _on_control_end_mouse_exited():
	$ControlEnd.release_focus()
