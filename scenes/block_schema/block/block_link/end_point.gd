extends Area2D
class_name EndPoint

enum PointType {COMMON_POINT, UNCOMMON_POINT}
@export var point_type: PointType

var connection_waiting:bool = false
var begin_point:BeginPoint = null:
	set(value):
		#get_parent().parent_block = null
		begin_point = value
		#if value != null:
			#get_parent().parent_block = value.get_parent()

func _ready():
	pass
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	draw_circle(Vector2.ZERO, 3, Color.WHEAT)

func _process(delta):
	pass




