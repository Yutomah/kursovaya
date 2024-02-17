extends GBlock
class_name GBlockBegin

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint
var zap:Zap = null
# Called when the node enters the scene tree for the first time.

func _ready():
	super._ready()
	PSM.activate_all_begin_blocks_wanted.connect(on_activate_all)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func zap_processing():
	
	if zap != null:
		zap.remove_myself()
	
	zap = Zap.new()
	zap.block_begin = self
	GB.line_creation_wanted.emit(zap)
	GB.create_log_group_wanted.emit(zap)
	if await zap_processing_control(zap):
		
		if begin_point.end_point != null:
			zap.log_group.write_record(block_name, self)
			begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist(zap)

func arg_zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		if begin_point.end_point != null:
			zap.log_group.write_record(block_name, self)
			begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist(zap)
			
func _on_activate_button_pressed():
	PSM.process_input(PSM.INPUT.LPLAY)
	zap_processing()
	

func on_activate_all():
	if $Control/MarginContainer/Content/MassActivationCheckbox.button_pressed:
		zap_processing()
