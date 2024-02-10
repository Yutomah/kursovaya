extends Camera2D


func _input(event):
	if event.is_action_released("LKM") and $"../..".LKM_pressed:
		$"../..".LKM_pressed = false
