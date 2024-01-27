extends Node2D

var connection_waiting:bool = false
var begin_node:Area2D
var previous_begin_node:Area2D

func _ready():
	GB.link_activated.connect(on_link_activated)
	GB.link_deactivated.connect(on_link_deactivated)
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	draw_circle(Vector2.ZERO, 3, Color.WHEAT)

func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_released("LKM"):
		if not previous_begin_node == null:
			previous_begin_node.get_node("Line2D").points[1] = Vector2.ZERO
		var t_begin_node = begin_node
		GB.link_received.emit(t_begin_node, self)
	
func on_link_activated(begin_node:Area2D):
	self.begin_node = null
	if get_parent() != begin_node.get_parent():
		connection_waiting = true
		self.begin_node = begin_node
	
func on_link_deactivated():
	connection_waiting = false


