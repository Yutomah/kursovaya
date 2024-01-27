extends Node2D

var connection_waiting:bool = false
var begin_node:Area2D
var previous_begin_node:Area2D

func _ready():
	GB.link_activated.connect(on_link_activated)
	GB.link_received.connect(on_link_received)
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	draw_circle(Vector2.ZERO, 3, Color.WHEAT)

func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_released("LKM") and connection_waiting:
		if not previous_begin_node == null:
			previous_begin_node.get_node("Line2D").points[1] = Vector2.ZERO
		var t_begin_node = begin_node
		GB.link_received.emit(t_begin_node, self)
	
func on_link_activated(begin_node:Area2D):
	connection_waiting = true
	self.begin_node = begin_node
	
func on_link_received(_begin_node: Area2D, _end_node :Area2D):
	connection_waiting = false
	begin_node = null


