extends Area2D
class_name EndPoint

enum PointType {COMMON_POINT, UNCOMMON_POINT}
@export var point_type: PointType

var connection_waiting:bool = false
var begin_point:BeginPoint = null:
	set(value):
		begin_point = value
		
		var my_block = get_parent().get_parent() as Block
		var value_block = null
		if value != null:
			value_block =value.get_parent().get_parent() as Block
		my_block.parent_blocks[point_type] = value_block

func _ready():
	pass
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	draw_circle(Vector2.ZERO, 3, Color.WHEAT)

func _process(delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("LKM") and GB.focus_window == GB.MAIN_WINDOW \
	and GB.current_tool == GB.SELECTION_TOOL:
		if begin_point != null:
			begin_point._on_input_event(viewport,event,shape_idx)
			get_parent().get_parent().LKM_pressed = false
