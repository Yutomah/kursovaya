extends AZone
class_name AIfZone2

@export var center_list:VBoxContainer
@export var horizontal_list:HBoxContainer
@export var left_body:AZone
@export var right_body:AZone
@export var left_list:VBoxContainer
@export var right_list:VBoxContainer

var default_min_size = Vector2(300,200)

func _ready():
	super._ready()
	horizontal_list.add_theme_constant_override("separation", 100)
	main_list.custom_minimum_size = GB.default_min_size
	

func update_alignment():
	left_body.update_alignment()
	right_body.update_alignment()




func spawn_left(block):
	left_body.spawn_block(block, 0)
	
func spawn_right(block):
	right_body.spawn_block(block, 0)

func get_left_size():
	return left_list.size
	
func get_right_size():
	return right_list.size
	
func min_size_to_default():
	left_list.custom_minimum_size = default_min_size
	right_list.custom_minimum_size = default_min_size

func change_min_size(left_right_size:Array):
	left_list.custom_minimum_size.x = left_right_size[0]
	right_list.custom_minimum_size.x = left_right_size[1]
