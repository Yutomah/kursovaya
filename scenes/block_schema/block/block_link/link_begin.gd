extends Node2D

var LKM_pressed = false
var end_node:Area2D

func _ready():
	GB.link_received.connect(on_link_received)
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	
func _process(delta):
	if LKM_pressed:
		$Line2D.points[1] = get_local_mouse_position()

func _unhandled_input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		LKM_pressed = false
		$Line2D.points[1] = Vector2.ZERO
		GB.link_deactivated.emit()
		
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("LKM"):
		GB.link_activated.emit(self)
		LKM_pressed = true
		
func on_link_received(begin_node: Area2D, end_node: Area2D):
	if begin_node == self:
		end_node.previous_begin_node = self
		var pos = to_local(end_node.to_global(Vector2.ZERO))
		$Line2D.points[1] = pos
		self.end_node = end_node
	
