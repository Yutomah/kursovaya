extends Window


	
# Called when the node enters the scene tree for the first time.
func _ready():
	GB.change_drawing_window_vision.connect(func(): visible = not visible)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_close_requested():
	visible = false


func _on_gui_focus_changed(node):
	pass


func _on_mouse_entered():
	GB.focus_window = GB.DRAW_WINDOW
	print("drawing_window")


func _on_mouse_exited():
	GB.focus_window = GB.NONE_WINDOW
