extends Control
class_name Block

var LKM_pressed:bool = false
var old_mouse_position:Vector2

var parent_blocks:Dictionary
var child_blocks:Dictionary

func _ready():
	$VBoxContainer/Me.text = self.name
	init_parent_child_blocks_dict()
	GB.focus_window = GB.MAIN_WINDOW
	GB.current_tool = GB.SELECTION_TOOL
	GB.block_schema_rkm_menu_opened.connect(on_block_schema_rkm_menu_opened)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if LKM_pressed:
		var dif = get_local_mouse_position() - old_mouse_position
		position += dif
		
		for begin_point in $BeginPoints.get_children():
			if begin_point.end_point != null:
				begin_point.get_node("Line2D").points[1] -= dif
		
		for end_point in $EndPoints.get_children():
			if end_point.begin_point != null:
				end_point.begin_point.get_node("Line2D").points[1] += dif
		

func _on_gui_input(event):
	if event.is_action_pressed("LKM") and GB.focus_window == GB.MAIN_WINDOW \
	and GB.current_tool == GB.SELECTION_TOOL:
		LKM_pressed = true
		old_mouse_position = get_local_mouse_position()
		$BlockRkmMenu.hide()
		GB.is_block_rkm_menu_open = false
		
	if event.is_action_released("LKM"):
		LKM_pressed = false
		
		
	if event.is_action_pressed("RKM") and GB.focus_window == GB.MAIN_WINDOW \
	and GB.current_tool == GB.SELECTION_TOOL:
		$BlockRkmMenu.position = get_local_mouse_position()
		$BlockRkmMenu.show()
		GB.block_rkm_menu_opened.emit()
		GB.is_block_rkm_menu_open = true
		
		
	if event.is_action_pressed("LKM"):
		$BlockRkmMenu.hide()
		GB.is_block_rkm_menu_open = false
		

func init_parent_child_blocks_dict():
	for begin_point:BeginPoint in $BeginPoints.get_children():
		child_blocks[begin_point.point_type] = null
	for end_point:EndPoint in $EndPoints.get_children():
		parent_blocks[end_point.point_type] = null

func _on_mouse_entered():
	GB.focus_window = GB.MAIN_WINDOW

func on_block_schema_rkm_menu_opened():
	$BlockRkmMenu.hide()

func _on_mouse_exited():
	GB.is_block_rkm_menu_open = false

func delete_myself():
	for begin_point:BeginPoint in $BeginPoints.get_children():
		if begin_point.end_point != null:
			begin_point.end_point.begin_point = null
	for end_point:EndPoint in $EndPoints.get_children():
		if end_point.begin_point != null:
			end_point.begin_point.end_point = null
		end_point.begin_point.get_node("Line2D").points[1] = Vector2.ZERO
	queue_free()
