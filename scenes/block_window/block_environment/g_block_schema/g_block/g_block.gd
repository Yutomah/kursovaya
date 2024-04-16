extends Node2D
class_name GBlock

var LKM_pressed:bool = false
var old_mouse_position:Vector2

var context_menu:PackedScene = preload("res://scenes/context_menu_layer/context_menu\
/block_context_menu/g_block_context_menu.tscn")

var delay:float = 0.3
var related_log_records:Array[LogRecord] = []

var block_name:String

func _ready():
	GB.block_name_changed.emit()
	PSM.state_changed.connect(on_state_changed)
	
func _process(_delta):
	if LKM_pressed:
		var dif = get_local_mouse_position() - old_mouse_position
		position += dif
		
		for begin_point in $BeginPoints.get_children():
			begin_point.update_static_line_pos()
		
		for end_point in $EndPoints.get_children():
			if end_point.begin_point != null:
				end_point.begin_point.update_static_line_pos()
				



func _on_control_gui_input(event):
	if event.is_action_pressed("LKM") and GB.current_tool == GB.HAND_TOOL:
		GB.hand_tool_on_block_pressed.emit(event)
		
	if event.is_action_pressed("LKM") and GB.current_tool == GB.SELECTION_TOOL:
		LKM_pressed = true
		old_mouse_position = get_local_mouse_position()
		
		$Control.accept_event()
	
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		m_highlight()
		m_highlight_related_log_records()
		
	if event.is_action_pressed("RKM"):
		open_context_menu()
		$Control.accept_event()
		
func _input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		LKM_pressed = false

func remove_myself():
	for begin_point:GBeginPoint in $BeginPoints.get_children():
		begin_point.remove_link()
	for end_point:GEndPoint in $EndPoints.get_children():
		end_point.remove_link()
	queue_free()
	
func open_context_menu():
	var menu := context_menu.instantiate() as BlockContextMenu
	menu.block = self
	GB.context_menu_open_wanted.emit(menu)

func zap_processing_control(zap:Zap):
	m_highlight()
	
	await get_tree().create_timer(delay).timeout
	
	if PSM.state == PSM.STATE.PAUSE:
		await PSM.state_changed
		
	m_dehighlight()
	
	return PSM.state == PSM.STATE.PLAY and zap != null \
	and zap.grid_line != null and !zap.grid_line.is_queued_for_deletion()
	


func _on_tree_exited():
	GB.block_name_changed.emit()

func m_highlight():
	$Control.modulate = Color.BURLYWOOD

func m_dehighlight():
	$Control.modulate = Color.WHITE

func m_highlight_related_log_records():
	for log_record:LogRecord in related_log_records:
		log_record.m_highlight()

func m_dehighlight_related_log_records():
	for log_record:LogRecord in related_log_records:
		log_record.m_dehighlight()
		
func error_base():
	remove_from_group("working_blocks")
	PSM.process_input(PSM.INPUT.LSTOP)
	
	
func error_next_block_not_exist(zap:Zap):
	zap.log_group.write_record("Отсутствует блок для последующей передачи", self)
	error_base()

func error_line_beyond_borders(zap:Zap):
	zap.log_group.write_record("Линия вышла за границы доски", self)
	error_base()
	
func error_no_selected_begin_block(zap:Zap):
	zap.log_group.write_record("Не выбрано функции в блоке функции", self)
	error_base()


func _on_control_focus_exited():
	m_dehighlight()
	m_dehighlight_related_log_records()

func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			related_log_records = []
		PSM.STATE.PAUSE:
			pass
		PSM.STATE.STOP:
			pass
		PSM.STATE.CLEAR:
			related_log_records = []
		

