extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GB.camera_to_default_wanted.connect(on_camera_to_default_wanted)
	GB.camera_zoom_to.connect(on_camera_change_zoom)
	
	
func on_camera_to_default_wanted(window_type):
	if window_type == GB.WIN_TYPE.DRAW_WINDOW:
		offset = Vector2.ZERO
		zoom = Vector2.ONE

func on_camera_change_zoom(zoom_value, window_type):
	if window_type == GB.WIN_TYPE.DRAW_WINDOW:
		zoom = Vector2(zoom_value, zoom_value)
		
