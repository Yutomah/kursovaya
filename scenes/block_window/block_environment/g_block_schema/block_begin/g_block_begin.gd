extends GBlock
class_name GBlockBegin

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	GB.activate_all_begin_blocks_wanted.connect(zap_processing)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func zap_processing():
	var zap = Zap.new()
	zap.block_begin = self
	GB.line_creation_wanted.emit(zap)
	print(1)
	if await zap_processing_control(zap):
		print(3)
		if begin_point.end_point != null:
			begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist()

func arg_zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		if begin_point.end_point != null:
			begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist()
			
func _on_activate_button_pressed():
	zap_processing()
	GB.running = true

func on_activate_all_begin_buttons_pressed():
	if $Control/MarginContainer/Content/MassActivationCheckbox.button_pressed():
		zap_processing()
