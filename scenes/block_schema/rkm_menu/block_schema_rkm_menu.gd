extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("RKM") and GB.focus_window == GB.MAIN_WINDOW \
	and GB.current_tool == GB.SELECTION_TOOL:
		position = get_parent().get_local_mouse_position()
		show()
	if event.is_action_pressed("LKM"):
		hide()
