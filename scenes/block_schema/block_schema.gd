extends Node2D

var active_begin_node:Area2D
var connection_active:bool = false
	
func _ready():
	GB.link_activated.connect((on_link_activated))
	GB.link_deactivated.connect(on_link_deactivated)
	
				
func on_link_activated(begin_node:Area2D):
	connection_active = true
	active_begin_node = begin_node
	activate_end_nodes(begin_node)
				
func on_link_deactivated(last_mouse_pos: Vector2):
	var end_node = get_end_node_on_mouse(last_mouse_pos)
	
	if active_begin_node.end_node != null:
		#print(active_begin_node.end_node.begin_node.get_parent().name)
		active_begin_node.end_node.begin_node = null
		#print(active_begin_node.end_node.begin_node)
		
	active_begin_node.end_node = end_node 
		
	var pos = Vector2.ZERO
	if end_node != null:
		remove_dublicate_connections(end_node)
		end_node.begin_node = active_begin_node
		pos = active_begin_node.to_local(end_node.to_global(Vector2.ZERO))
	active_begin_node.get_node("Line2D").points[1] = pos
	
	
	connection_active = false
	active_begin_node = null
	
	deactivate_end_nodes()
	
		
func get_end_node_on_mouse(last_mouse_pos: Vector2):
	for block in get_children():
		var connection_point = block.get_node("LinkEnd")
		if connection_point.connection_waiting:
			var col_shape = connection_point.get_node("CollisionShape2D") as CollisionShape2D
			var radius = col_shape.shape.radius
			var pos = col_shape.to_global(Vector2.ZERO)
			if Geometry2D.is_point_in_circle(last_mouse_pos, pos, radius):
				return connection_point
	return null

func remove_dublicate_connections(end_node:Area2D):
	for block in get_children():
		var begin_node = block.get_node("LinkBegin") as begin_point
		if begin_node == end_node.begin_node:
			end_node.begin_node.get_node("Line2D").points[1] = Vector2.ZERO
			end_node.begin_node.end_node = null
			end_node.begin_node = null
	
func activate_end_nodes(begin_node:Area2D):
	for block in get_children():
		var connection_point = block.get_node("LinkEnd") as end_point
		if  block != begin_node.get_parent():
			connection_point.connection_waiting = true
			
func deactivate_end_nodes():
	for block in get_children():
		var connection_point = block.get_node("LinkEnd") as end_point
		connection_point.connection_waiting = false
