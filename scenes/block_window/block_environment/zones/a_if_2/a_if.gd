extends MarginContainer
class_name AIf

var zone:MarginContainer
@export var main_list:VBoxContainer
@export var horizontal_list:HBoxContainer
@export var left_sub_zone:AIfSubZone
@export var right_sub_zone:AIfSubZone
@export var left_list:VBoxContainer
@export var right_list:VBoxContainer
@export var a_if_block:AIfBlock

func _ready():
	horizontal_list.add_theme_constant_override("separation", 100)
	main_list.custom_minimum_size = GB.default_min_size
	main_list.add_theme_constant_override("separation", GB.v_separation)

func update_alignment():
	left_sub_zone.update_alignment()
	right_sub_zone.update_alignment()
	
	a_if_block.align_block(get_left_size().x)



func spawn_left(block):
	left_sub_zone.spawn_block(block, 0)
	
func spawn_right(block):
	print_debug(right_sub_zone)
	print_debug(left_sub_zone)
	print_debug(main_list)
	print_debug(right_list)
	right_sub_zone.spawn_block(block, 0)

func get_left_size():
	return left_list.size
	
func get_right_size():
	return right_list.size
	
func min_size_to_default():
	left_list.custom_minimum_size = GB.default_min_size
	right_list.custom_minimum_size = GB.default_min_size

func change_min_size(left_right_size:Array):
	left_list.custom_minimum_size.x = left_right_size[0]
	right_list.custom_minimum_size.x = left_right_size[1]
