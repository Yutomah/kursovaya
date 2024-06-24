extends MarginContainer
class_name AIf3

var zone:MarginContainer

@onready var horizontal_list: HBoxContainer = %horizontal_list
@onready var main_list: VBoxContainer = %MainList
@onready var a_if_block: AIfBlock3 = %a_if_block
@onready var left_sub_zone: AIfSubZone3 = %left_sub_zone
@onready var right_sub_zone: AIfSubZone3 = %right_sub_zone

@onready var lines: Node2D = %Lines
@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit

@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton
var zone_type = "AIf"

func _ready():
	horizontal_list.add_theme_constant_override("separation", 100)
	custom_minimum_size = GB.default_min_size
	main_list.add_theme_constant_override("separation", GB.v_separation)
	spawn_block_button.item_pressed.connect(on_item_pressed)
	


func get_left_next_block():
	if left_sub_zone.main_list.get_child_count()>0:
		return left_sub_zone.get_first_block()
	else:
		return zone.get_next_block(self)
		
func get_right_next_block():
	if right_sub_zone.main_list.get_child_count()>0:
		return right_sub_zone.get_first_block()
	else:
		return zone.get_next_block(self)
		
func get_next_block(block):
	return zone.get_next_block(self)
	
func get_first_block():
	return a_if_block
	
#region saving
func serialize():
	var dict = {
		"type":zone_type,
		"a_if_block": a_if_block.serialize(),
		"left_list":[],
		"right_list":[]
	}
	
	for i in range(0, left_sub_zone.main_list.get_child_count()):
		dict["left_list"].append(left_sub_zone.main_list.get_child(i).serialize())
	
	for i in range(0, right_sub_zone.main_list.get_child_count()):
		dict["right_list"].append(right_sub_zone.main_list.get_child(i).serialize())
		
	return dict	
	
func deserialize(dict):
	a_if_block.deserialize(dict["a_if_block"])
	
	for child_dict in dict["left_list"]:
		var block = get_block_from_type(dict["type"])
		left_sub_zone.spawn_block(block, -1)
		block.deserialize()
	
	for child_dict in dict["right_list"]:
		var block = get_block_from_type(dict["type"])
		right_sub_zone.spawn_block(block, -1)
		block.deserialize()
		
func get_block_from_type(dict_type):
	var block = null
	match dict_type:
		"Блок действия":
			block = load("res://scenes/block_window/block_environment/a_block_schema/a_action_block/a_action_block.tscn")
		"AIf":
			block = load("res://scenes/block_window/block_environment/zones/a_if_3/a_if_3.tscn")
		"AForZone":
			block = load("res://scenes/block_window/block_environment/zones/a_for_zone/a_for_zone.tscn")
		"AWhileZone":
			block = load("res://scenes/block_window/block_environment/zones/a_while_zone/a_while_zone.tscn")
		"Блок функции":
			block = load("res://scenes/block_window/block_environment/a_block_schema/a_function_block/a_function_block.tscn")
	return block
#endregion

#region Alignment
func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)

func update_alignment():
	min_size_to_default()
	left_sub_zone.update_alignment()
	right_sub_zone.update_alignment()
	
	connect_blocks()
	#a_if_block.align_block(get_left_size().x)


func get_inner_size():
	var l = left_sub_zone.get_main_list_size().x
	var r = right_sub_zone.get_main_list_size().x
	return [l,r]

func spawn_left(block):
	left_sub_zone.spawn_block(block, 0)
	
func spawn_right(block):
	right_sub_zone.spawn_block(block, 0)

func get_left_size():
	return left_sub_zone.size
	
func get_right_size():
	return right_sub_zone.size
	
func min_size_to_default():
	left_sub_zone.set_min_size(GB.default_min_size)
	right_sub_zone.set_min_size(GB.default_min_size)

func change_min_size(left_right_size:Array):
	left_sub_zone.set_min_size(Vector2(left_right_size[0], GB.default_min_size.y))
	right_sub_zone.set_min_size(Vector2(left_right_size[1], GB.default_min_size.y))

func rec_update_line_connections():
	left_sub_zone.rec_update_line_connections()
	right_sub_zone.rec_update_line_connections()
	
	left_sub_zone.update_line_connections()	
	right_sub_zone.update_line_connections()	
			
func update_line_connections():
	entrance.global_position = a_if_block.entrance.global_position
	exit.global_position = Vector2(entrance.global_position.x, global_position.y + size.y)
	
	spawn_block_button.position = exit.position + Vector2(0,-10)
func rec_connect_blocks():
	left_sub_zone.rec_connect_blocks()
	right_sub_zone.rec_connect_blocks()
	
	left_sub_zone.connect_blocks()
	right_sub_zone.connect_blocks()
	
func connect_blocks():
	for line in lines.get_children():
		line.queue_free()
	
	connect_first_left()
	connect_firts_right()
	
	connect_last_left()
	connect_last_right()
		
func connect_first_left():
	var line:Line2D = Line2D.new()
	line.default_color = GB.line_color
	line.width = GB.line_width
	line.antialiased = true
	lines.add_child(line)
	
	var from_child = a_if_block.left_exit
	var from_point = line.to_local(from_child.global_position)
	
	
	if left_sub_zone.main_list.get_child_count()>0:
		var to_child = left_sub_zone.main_list.get_child(0)
		var to_point = line.to_local(to_child.entrance.global_position)
		
		line.add_point(from_point)
		line.add_point(Vector2(to_point.x, from_point.y))
		line.add_point(to_point)
	else:
		line.add_point(from_point)
		line.add_point(Vector2(from_point.x - GB.default_min_size.x/2, from_point.y))
		line.add_point(Vector2(from_point.x - GB.default_min_size.x/2, exit.position.y))
		line.add_point(exit.position)

func connect_firts_right():
	var line:Line2D = Line2D.new()
	line.default_color = GB.line_color
	line.width = GB.line_width
	line.antialiased = true
	lines.add_child(line)
	
	var from_child = a_if_block.right_exit
	var from_point = line.to_local(from_child.global_position)
	
	
	if right_sub_zone.main_list.get_child_count()>0:
		var to_child = right_sub_zone.main_list.get_child(0)
		var to_point = line.to_local(to_child.entrance.global_position)
		
		line.add_point(from_point)
		line.add_point(Vector2(to_point.x, from_point.y))
		line.add_point(to_point)
	else:
		line.add_point(from_point)
		line.add_point(Vector2(from_point.x + GB.default_min_size.x/2, from_point.y))
		line.add_point(Vector2(from_point.x + GB.default_min_size.x/2, exit.position.y))
		line.add_point(exit.position)
		
func connect_last_left():
	if left_sub_zone.main_list.get_child_count()>0:
		var line:Line2D = Line2D.new()
		line.default_color = GB.line_color
		line.width = GB.line_width
		line.antialiased = true
		lines.add_child(line)
		
		var from_child = left_sub_zone.main_list.get_child(-1)
		var from_point = line.to_local(from_child.exit.global_position)
		
		line.add_point(from_point)
		line.add_point(Vector2(from_point.x, exit.position.y))
		line.add_point(exit.position)
	
	
func connect_last_right():
	if right_sub_zone.main_list.get_child_count()>0:
		var line:Line2D = Line2D.new()
		line.default_color = GB.line_color
		line.width = GB.line_width
		line.antialiased = true
		lines.add_child(line)
		
		var from_child = right_sub_zone.main_list.get_child(-1)
		var from_point = line.to_local(from_child.exit.global_position)
		
		line.add_point(from_point)
		line.add_point(Vector2(from_point.x, exit.position.y))
		line.add_point(exit.position)
#endregion
