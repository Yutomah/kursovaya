extends Window


	
# Called when the node enters the scene tree for the first time.
func _ready():
	GB.change_drawing_window_vision.connect(func(): visible = not visible)

func _on_close_requested():
	visible = false


func _on_mouse_entered():
	grab_focus()

