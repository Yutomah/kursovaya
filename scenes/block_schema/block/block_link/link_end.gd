extends Area2D
class_name end_point

var connection_waiting:bool = false
var begin_node:Area2D = null:
	set(value):
		get_parent().parent_block = null
		print(value)
		begin_node = value
		if value != null:
			get_parent().parent_block = value.get_parent()

func _ready():
	pass
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	draw_circle(Vector2.ZERO, 3, Color.WHEAT)

func _process(delta):
	pass




