extends Node2D
class_name GBlock

var LKM_pressed:bool = false
var old_mouse_position:Vector2

var context_menu:PackedScene = preload("res://scenes/context_menu_layer/context_menu\
/block_context_menu/g_block_context_menu.tscn")

var delay:float = 0.3
signal pause_remove_wanted()

func _ready():
	GB.continue_all_blocks_wanted.connect(func():pause_remove_wanted.emit())
	GB.stop_all_blocks_wanted.connect(func():pause_remove_wanted.emit())
	
func _process(_delta):
	if LKM_pressed:
		var dif = get_local_mouse_position() - old_mouse_position
		position += dif
		
		for begin_point in $BeginPoints.get_children():
			begin_point.update_static_line_pos()
		
		for end_point in $EndPoints.get_children():
			if end_point.begin_point != null:
				end_point.begin_point.update_static_line_pos()
				
func _on_control_mouse_entered():
	$Control.grab_focus()


func _on_control_gui_input(event):
	if event.is_action_pressed("LKM") and GB.current_tool == GB.SELECTION_TOOL:
		LKM_pressed = true
		old_mouse_position = get_local_mouse_position()
		$Control.accept_event()
		
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

func zap_processing_control():
	$Control.modulate = Color.BURLYWOOD
	await get_tree().create_timer(delay).timeout
	if GB.paused:
		await GB.continue_all_blocks_wanted
	
	$Control.modulate = Color.WHITE
	return true if GB.running else false


