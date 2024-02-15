extends SubViewportContainer

@export var camera:Camera2D

var LKM_pressed:bool = false
var old_mouse_position:Vector2

func _ready():
	GB.camera_to_default_wanted.connect(camera_to_default)
	
	
func _process(_delta):
	if LKM_pressed:
		camera.offset += old_mouse_position - $SubViewport/Camera2D.get_global_mouse_position()
	
func _on_mouse_entered():
	grab_focus()

func _on_gui_input(event):
	if event.is_action_pressed("LKM") and GB.current_tool == GB.HAND_TOOL:
		LKM_pressed = true
		old_mouse_position = $SubViewport/Camera2D.get_global_mouse_position()

func _input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		LKM_pressed = false

func camera_to_default():
	camera.offset = Vector2.ZERO

