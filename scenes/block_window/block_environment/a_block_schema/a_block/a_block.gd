extends Control
class_name ABlock

@export var background:TextureButton
@export var body:Control

func _ready():
	custom_minimum_size = background.size
	body.custom_minimum_size = background.size
