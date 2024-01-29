extends Camera2D

var old_mouse_position:Vector2
var LKM_pressed:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_movement()

func camera_movement():
	if Input.is_action_just_pressed("LKM") and GB.focus_window == GB.MAIN_WINDOW \
	and GB.current_tool == GB.HAND_TOOL:
		LKM_pressed = true
		old_mouse_position = get_global_mouse_position()
	if Input.is_action_just_released("LKM"):
		LKM_pressed = false
	if LKM_pressed:
		offset += old_mouse_position - get_global_mouse_position()
