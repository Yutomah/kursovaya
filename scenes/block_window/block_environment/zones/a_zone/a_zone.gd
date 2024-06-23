extends MarginContainer
class_name AZone

@export var zone:MarginContainer
@onready var main_list: VBoxContainer = %MainList
@onready var lines: Node2D = %Lines

func _ready():
	main_list.add_theme_constant_override("separation", GB.v_separation)
	add_theme_constant_override("margin_bottom", GB.left_right_margin)
	set_min_size(GB.default_min_size)
	
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)
	
#region Alignment
func set_min_size(min_size:Vector2):
	custom_minimum_size = min_size
	size = min_size
	#
func spawn_block(ablock, pos:int):
	ablock.zone = self
	main_list.add_child(ablock)
	main_list.move_child(ablock, pos)
	
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)

func update_alignment():
	update_alignment_if()
			
	left_right_min_size_to_default()
	
	var left_right_size = get_max_left_right_min_size()
	
	
	change_left_right_min_size(left_right_size)
	align_blocks(left_right_size[0])
	
	
func update_alignment_if():
	for child in main_list.get_children():
		if "zone_type" in child and (child.zone_type == "AForZone" or child.zone_type == "AWhileZone"):
			child.update_alignment_if()
		if "zone_type" in child and child.zone_type == "AIf":
			child.update_alignment()
			
func left_right_min_size_to_default():
	for child in main_list.get_children():
		if "zone_type" in child and (child.zone_type == "AForZone" or child.zone_type == "AWhileZone"):
			child.left_right_min_size_to_default()
		if "zone_type" in child and child.zone_type == "AIf":
			child.min_size_to_default()
				
func get_max_left_right_min_size():
	var left:float = -1
	var right:float = -1

	
	for child in main_list.get_children():
		if "zone_type" in child and (child.zone_type == "AForZone" or child.zone_type == "AWhileZone"):
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

	return [left, right]
			
func change_left_right_min_size(left_right_size:Array):
	for child in main_list.get_children():
		if  "zone_type" in child and (child.zone_type == "AForZone" or child.zone_type == "AWhileZone"):
			child.change_left_right_min_size(left_right_size)
			
		if "zone_type" in child and child.zone_type == "AIf":
			child.change_min_size(left_right_size)
			
			#
func align_blocks(left_min_size:float):
	for child in main_list.get_children():
		if "zone_type" in child and (child.zone_type == "AForZone" or child.zone_type == "AWhileZone"):
			child.align_blocks(left_min_size)
			
		if "zone_type" in child and child.zone_type == "AIf":
			child.a_if_block.align_block(left_min_size)
			
		if child is ABlock:
			child.align_block(left_min_size)
			
			
			
func rec_update_line_connections():
	for child in main_list.get_children():
		if !(child is ABlock):
			child.rec_update_line_connections()
			child.update_line_connections()
			
func update_line_connections():
	pass
			#
func rec_connect_blocks():
	for child in main_list.get_children():
		if !(child is ABlock):
			child.rec_connect_blocks()
			child.connect_blocks()
			
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
		
		var from_point = line.to_local(from_child.exit.global_position)
		var to_point = line.to_local(to_child.entrance.global_position)
		
		line.add_point(from_point)
		line.add_point(to_point)
	
		
#endregion
