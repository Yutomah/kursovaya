extends AZone
class_name AIfZone

@export var center_list:VBoxContainer
@export var horizontal_list:HBoxContainer
@export var left_list:VBoxContainer
@export var right_list:VBoxContainer

func _ready():
	super._ready()
	horizontal_list.add_theme_constant_override("separation", 100)
	
var default_min_size = Vector2(300,200)
func spawn_right(block):
	right_list.add_child(block)
	right_list.move_child(block, 0)
	
func spawn_left(block):
	left_list.add_child(block)
	left_list.move_child(block, 0)

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
