extends AZone
class_name AIfZone

@export var center:VBoxContainer
@export var left:VBoxContainer
@export var right:VBoxContainer


func spawn_right(block):
	right.add_child(block)
	
func spawn_left(block):
	left.add_child(block)
