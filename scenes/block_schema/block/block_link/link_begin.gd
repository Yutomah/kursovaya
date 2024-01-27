extends Area2D
class_name begin_point

var LKM_pressed = false
var end_node:Area2D:
	set(value):
		get_parent().child_block = null
		end_node = value
		if value != null:
			get_parent().child_block = value.get_parent()

func _ready():
	pass
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	
func _process(delta):
	if LKM_pressed:
		$Line2D.points[1] = get_local_mouse_position()

func _unhandled_input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		GB.link_deactivated.emit(get_global_mouse_position())
		LKM_pressed = false
		
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("LKM"):
		GB.link_activated.emit(self)
		LKM_pressed = true
		
