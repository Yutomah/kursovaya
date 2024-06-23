extends Control
class_name ABlock

@export var zone:MarginContainer
@export var background:TextureButton
@export var body:Control

var related_log_records:Array[LogRecord] = []
var delay:float = 0.3

@onready var delete_button: Button = %DeleteButton

var block_type:String

func _ready():
	custom_minimum_size = background.size
	body.custom_minimum_size = background.size
	
	GB.block_name_changed.emit()
	PSM.state_changed.connect(on_state_changed)
	
func get_next_block():
	pass

func zap_processing_control(zap:Zap):
	a_highlight()
	
	await get_tree().create_timer(delay).timeout
	
	zap.a_begin_block.is_stepped = true
	
	if GB.is_step_by_step:
		zap.a_begin_block.is_stepped = true
		await GB.make_step
		zap.a_begin_block.is_stepped = false
	
	if PSM.state == PSM.STATE.PAUSE:
		await PSM.state_changed
		
	a_dehighlight()
	
	return PSM.state == PSM.STATE.PLAY and zap != null \
	and zap.grid_line != null and !zap.grid_line.is_queued_for_deletion()
	
func a_highlight():
	background.self_modulate = Color.AQUA
	
func a_dehighlight():
	background.self_modulate = Color.WHITE

func m_highlight_related_log_records():
	for log_record:LogRecord in related_log_records:
		log_record.m_highlight()

func m_dehighlight_related_log_records():
	for log_record:LogRecord in related_log_records:
		log_record.m_dehighlight()
		
func error_base(zap:Zap):
	zap.block_begin.remove_from_group("working_blocks")
	PSM.process_input(PSM.INPUT.LSTOP)

func error_line_beyond_borders(zap:Zap):
	zap.log_group.write_record("Линия вышла за границы доски", self)
	error_base(zap)
	
func error_no_selected_begin_block(zap:Zap):
	zap.log_group.write_record("Не выбрано функции в блоке функции", self)
	error_base(zap)

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
			
#region Alignment
func align_block(left_min_size:float):
	if left_min_size == -1:
		body.position.x = zone.size.x/2 - body.size.x/2
	else:
		body.position.x = left_min_size + GB.h_separation - body.size.x / 2 
	
func _on_delete_button_pressed() -> void:
	delete_me()
	
func delete_me():
	pass


#endregion
