extends MarginContainer
class_name AIf3

var zone:MarginContainer

@onready var horizontal_list: HBoxContainer = %horizontal_list
@onready var main_list: VBoxContainer = %MainList
@onready var a_if_block: AIfBlock3 = %a_if_block
@onready var left_sub_zone: AIfSubZone3 = %left_sub_zone
@onready var right_sub_zone: AIfSubZone3 = %right_sub_zone

var zone_type = "AIf"

func _ready():
	horizontal_list.add_theme_constant_override("separation", 100)
	custom_minimum_size = GB.default_min_size
	main_list.add_theme_constant_override("separation", GB.v_separation)

func update_alignment():
	min_size_to_default()
	left_sub_zone.update_alignment()
	right_sub_zone.update_alignment()
	
	#a_if_block.align_block(get_left_size().x)



func spawn_left(block):
	left_sub_zone.spawn_block(block, 0)
	
func spawn_right(block):
	right_sub_zone.spawn_block(block, 0)

func get_left_size():
	return left_sub_zone.get_main_list_size()
	
func get_right_size():
	return right_sub_zone.get_main_list_size()
	
func min_size_to_default():
	left_sub_zone.set_min_size(GB.default_min_size)
	right_sub_zone.set_min_size(GB.default_min_size)

func change_min_size(left_right_size:Array):
	left_sub_zone.set_min_size(Vector2(left_right_size[0], GB.default_min_size.y))
	right_sub_zone.set_min_size(Vector2(left_right_size[1], GB.default_min_size.y))
