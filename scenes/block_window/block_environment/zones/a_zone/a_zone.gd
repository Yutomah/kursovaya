extends MarginContainer
class_name AZone

@export var main_list:VBoxContainer

func spawn_block(ablock, pos:int):
	main_list.add_child(ablock)
	main_list.move_child(ablock, pos)
