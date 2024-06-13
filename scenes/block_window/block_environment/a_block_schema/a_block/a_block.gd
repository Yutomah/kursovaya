extends Control
class_name ABlock

@export var zone:MarginContainer
@export var background:TextureButton
@export var body:Control

func _ready():
	custom_minimum_size = background.size
	body.custom_minimum_size = background.size

func align_block(left_min_size:float):
	if left_min_size == -1:
		body.position.x = size.x/2 - body.size.x/2
	else:
		body.position.x = left_min_size + GB.h_separation - body.size.x / 2 
	
	
func delete_me():
	pass
