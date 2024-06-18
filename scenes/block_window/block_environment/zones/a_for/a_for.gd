extends MarginContainer
class_name AFor


var zone:MarginContainer
@export var a_for_block:AForBlock
@export var a_cycle_sub_zone:ACycleSubZone
@export var main_list:VBoxContainer
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	main_list.custom_minimum_size = GB.default_min_size
	main_list.add_theme_constant_override("separation", GB.v_separation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
