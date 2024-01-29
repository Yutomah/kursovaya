extends Area2D
class_name BeginPoint

var LKM_pressed = false
enum PointType {COMMON_POINT, TRUE_POINT, FALSE_POINT}
@export var point_type:PointType 

var end_point:EndPoint:
	set(value):
		end_point = value
		var my_block = get_parent().get_parent() as Block
		var value_block = null
		if value != null:
			value_block = value.get_parent().get_parent() as Block
			#print(value_block.name, value)
		my_block.child_blocks[point_type] = value_block

func _ready():
	pass
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)
	
func _process(delta):
	if LKM_pressed:
		$Line2D.points[1] = get_local_mouse_position()

func _unhandled_input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		GB.link_deactivated.emit(get_global_mouse_position())
		LKM_pressed = false
		
func _on_input_event(viewport, event, shape_idx):
	print("a")
	if event.is_action_pressed("LKM") and GB.focus_window == GB.MAIN_WINDOW \
	and GB.current_tool == GB.SELECTION_TOOL:
		GB.link_activated.emit(self)
		LKM_pressed = true
		get_parent().get_parent().LKM_pressed = false
		
