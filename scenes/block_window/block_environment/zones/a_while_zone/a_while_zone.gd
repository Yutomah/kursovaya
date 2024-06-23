extends AZone
class_name AWhileZone

var left_side:float
var right_side:float
var cycle_depth:float

@onready var a_while_block:AWhileBlock = %AWhileBlock

@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit
@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton

var zone_type = "AWhileZone"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	add_theme_constant_override("margin_bottom", 2*GB.left_right_margin)
	spawn_block_button.item_pressed.connect(on_item_pressed)
	#add_theme_constant_override("margin_left", GB.left_right_margin)
	#add_theme_constant_override("margin_right", GB.left_right_margin)

func get_next_block(block):
	for i in main_list.get_child_count():
		if main_list.get_child(i) == block:
			if main_list.get_child(-1) == block:
				return a_while_block
			else:
				var next_block = main_list.get_child(i+1)
				if next_block is ABlock:
					return next_block
				else:
					return next_block.get_first_block()
	
func get_next_block_exit(block):
	return zone.get_next_block(self)
	
func get_first_block():
	return a_while_block
	
#region Alignment
func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_cycle_depth():
	var depth = 0
	for child in main_list.get_children():
		if child is AWhileZone or child is AForZone:
			var t = child.get_cycle_depth()
			if t > depth:
				depth = t
				
	return depth + 1
			
func get_inner_size():
	var left:float = -1
	var right:float = -1
	
	for child in main_list.get_children():
		if child is AWhileZone or child is AForZone:
			var left_right = child.get_inner_size()
				
			if left < left_right[0]:
				left = left_right[0]
			
			if right < left_right[1]:
				right = left_right[1]
		
		if child is AIf3:
			var left_right = child.get_inner_size()
			
			if left < left_right[0]:
				left = left_right[0]
				
			if right < left_right[1]:
				right = left_right[1]
				
	return [left, right]
			
func get_max_left_right_min_size():
	var left:float = -1
	var right:float = -1

	
	for child in main_list.get_children():
		if child is AWhileZone or child is AForZone:
			var left_right = child.get_max_left_right_min_size()
				
			if left < left_right[0]:
				left = left_right[0]
			
			if right < left_right[1]:
				right = left_right[1]
			
		if "zone_type" in child and child.zone_type == "AIf":
			if left < child.get_left_size().x:
				left = child.get_left_size().x
				
			if right < child.get_right_size().x:
				right = child.get_right_size().x
	
	
	#left_side = left
	#right_side = right
	#cycle_depth = self.get_cycle_depth()
	
	return [left, right]


func update_line_connections():
	entrance.global_position = a_while_block.entrance.global_position
	exit.global_position = Vector2(entrance.global_position.x, global_position.y + size.y)
	
	spawn_block_button.position = exit.position + Vector2(0,-10)
	
	
	var left_right = get_inner_size()
	if left_right[0] == -1:
		left_side = entrance.position.x - a_while_block.body.size.x/2
	else:
		left_side = entrance.position.x - left_right[0] - GB.left_right_margin/2
		
	if left_right[1] == -1:
		right_side = entrance.position.x + a_while_block.body.size.x/2
	else:
		right_side = entrance.position.x + left_right[1] + GB.left_right_margin/2
	cycle_depth = get_cycle_depth()
	
	
func connect_blocks():
	for line in lines.get_children():
		line.queue_free()
	
	for i in main_list.get_child_count()-1:
		var from_child = main_list.get_child(i)
		var to_child = main_list.get_child(i+1)
		
		var line:Line2D = Line2D.new()
		line.default_color = GB.line_color
		line.width = GB.line_width
		line.antialiased = true
		lines.add_child(line)
		
		var from_point
		if from_child is AWhileBlock:
			from_point = line.to_local(from_child.cycle_exit.global_position)
		else:
			from_point = line.to_local(from_child.exit.global_position)
			
		var to_point = line.to_local(to_child.entrance.global_position)
		
		line.add_point(from_point)
		line.add_point(to_point)
	
	connect_cycle_loop()
	connect_to_exit()
	
func connect_cycle_loop():
	var line:Line2D = Line2D.new()
	line.default_color = GB.line_color
	line.width = GB.line_width
	line.antialiased = true
	lines.add_child(line)
	
			
	var from_child = main_list.get_child(-1)
	var to_child = main_list.get_child(0)
	
	var from_point
	if from_child is AWhileBlock:
		from_point = line.to_local(from_child.cycle_exit.global_position)
	else:
		from_point = line.to_local(from_child.exit.global_position)
		
	var to_point = line.to_local(to_child.cycle_entrance.global_position)
	
	line.add_point(from_point)
	line.add_point(Vector2(from_point.x, exit.position.y - GB.left_right_margin))
	line.add_point(Vector2(left_side - cycle_depth*GB.left_right_margin, exit.position.y -GB.left_right_margin))
	line.add_point(Vector2(left_side - cycle_depth*GB.left_right_margin, to_point.y))
	line.add_point(to_point)
	
func connect_to_exit():
	var line:Line2D = Line2D.new()
	line.default_color = GB.line_color
	line.width = GB.line_width
	line.antialiased = true
	lines.add_child(line)

	var from_child = main_list.get_child(0)
	var from_point = line.to_local(from_child.exit.global_position)
	
	line.add_point(from_point)
	line.add_point(Vector2(right_side + cycle_depth*GB.left_right_margin, from_point.y))
	line.add_point(Vector2(right_side + cycle_depth*GB.left_right_margin, exit.position.y))
	line.add_point(exit.position)
#endregion
