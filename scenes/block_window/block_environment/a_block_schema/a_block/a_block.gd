extends Control
class_name ABlock

@export var background:TextureButton
@export var body:Control

func _ready():
	print_debug(background.size)
	custom_minimum_size = background.size
	print_debug(custom_minimum_size)
	body.custom_minimum_size = background.size
