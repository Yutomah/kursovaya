extends Node2D

var active_begin_point:BeginPoint
	
func _ready():
	GB.link_activated.connect((on_link_activated))
	GB.link_deactivated.connect(on_link_deactivated)
	
				
func on_link_activated(begin_point:BeginPoint):
	active_begin_point = begin_point
	activate_end_points(begin_point)
				
func on_link_deactivated(last_mouse_pos: Vector2):
	var active_end_point = get_end_node_on_mouse(last_mouse_pos)
	
	abort_existing_link(active_begin_point)
	
	if active_end_point != null:
		create_new_link(active_begin_point, active_end_point)
		
	active_begin_point = null
	
	deactivate_end_nodes()
	
func abort_existing_link(begin_point:BeginPoint):
	if begin_point.end_point != null:
		begin_point.end_point.begin_point = null
	begin_point.end_point = null
	begin_point.get_node("Line2D").points[1] = Vector2.ZERO

func create_new_link(begin_point:BeginPoint, end_point:EndPoint):
	remove_dublicate_connections(end_point)
	end_point.begin_point = begin_point
	begin_point.end_point = end_point
	var pos = begin_point.to_local(end_point.to_global(Vector2.ZERO))
	active_begin_point.get_node("Line2D").points[1] = pos
	
func get_end_node_on_mouse(last_mouse_pos: Vector2):
	for block in get_children():
		for end_point:EndPoint in block.get_node("EndPoints").get_children():
			if end_point.connection_waiting:
				var col_shape = end_point.get_node("CollisionShape2D") as CollisionShape2D
				var radius = col_shape.shape.radius
				var pos = col_shape.to_global(Vector2.ZERO)
				if Geometry2D.is_point_in_circle(last_mouse_pos, pos, radius):
					return end_point
	return null

func remove_dublicate_connections(end_point:Area2D):
	for block in get_children():
		for begin_point:BeginPoint in block.get_node("BeginPoints").get_children():
			if begin_point.end_point == end_point:
				begin_point.get_node("Line2D").points[1] = Vector2.ZERO
				begin_point.end_point.begin_point = null
				begin_point.end_point = null
	
func activate_end_points(begin_point:BeginPoint):
	for block in get_children():
		for end_point:EndPoint in block.get_node("EndPoints").get_children():
			if  block != begin_point.get_parent().get_parent():
				end_point.connection_waiting = true
				print(block.name)
				
	print("\n")
			
func deactivate_end_nodes():
	for block in get_children():
		for end_point:EndPoint in block.get_node("EndPoints").get_children():
			end_point.connection_waiting = false
