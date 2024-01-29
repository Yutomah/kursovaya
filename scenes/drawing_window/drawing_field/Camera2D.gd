extends Camera2D

var old_mouse_position:Vector2
var LKM_pressed:bool = false

var zoom_list = [0.25, 0.5, 1, 2, 4]
var current_zoom = 2
var can_zoom:bool = true

func camera_movement():
	if Input.is_action_just_pressed("LKM") and GB.focus_window == GB.DRAW_WINDOW \
	and GB.current_tool == GB.HAND_TOOL:
		LKM_pressed = true
		old_mouse_position = get_global_mouse_position()
	if Input.is_action_just_released("LKM"):
		LKM_pressed = false
	if LKM_pressed:
		offset += old_mouse_position - get_global_mouse_position()
		
func camera_zoom(delta):
	if can_zoom and (Input.is_key_pressed(KEY_1) or Input.is_key_pressed(KEY_2)):
		if Input.is_key_pressed(KEY_1) and current_zoom > 0:
			current_zoom -= 1
		if Input.is_key_pressed(KEY_2) and current_zoom < 4:
			current_zoom += 1
		
		zoom = zoom_list[current_zoom] * Vector2.ONE
		can_zoom = false
		get_tree().create_timer(0.2).timeout.connect(func(): can_zoom = true)
			
func camera_to_default():
	offset = Vector2.ZERO
	current_zoom = 2
	zoom =  Vector2.ONE * zoom_list[current_zoom]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	GB.camera_to_default_wanted.connect(camera_to_default)
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_movement()
	camera_zoom(delta)
	if Input.is_key_pressed(KEY_3):
		camera_to_default()
	pass
