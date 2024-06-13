extends MarginContainer
class_name AZone

var zone:MarginContainer
@export var main_list:VBoxContainer

func _ready():
	main_list.add_theme_constant_override("separation", GB.v_separation)
	
	
func spawn_block(ablock, pos:int):
	ablock.zone = self
	main_list.add_child(ablock)
	main_list.move_child(ablock, pos)
	
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_alignment)

func update_alignment():
	for child in main_list.get_children():
		if child is AZone:
			child.update_alignment()
			
	left_right_min_size_to_default()
	
	var left_right_size = get_max_left_right_min_size()
	
	
	change_left_right_min_size(left_right_size)
	align_blocks(left_right_size[0])
	
func left_right_min_size_to_default():
	for child in main_list.get_children():
		if child is AIfZone2:
			child.min_size_to_default()
				
func get_max_left_right_min_size():
	var left:float = -1
	var right:float = -1
	for child in main_list.get_children():
		if child is AIfZone2:
			if left < child.get_left_size().x:
				left = child.get_left_size().x
				
			if right < child.get_right_size().x:
				right = child.get_right_size().x
	
	return [left, right]
			
func change_left_right_min_size(left_right_size:Array):
	for child in main_list.get_children():
		if child is AIfZone2:
			child.change_min_size(left_right_size)
			
func align_blocks(left_min_size:float):
	for child in main_list.get_children():
		if child is ABlock:
			child.align_block(left_min_size)
