extends Block
class_name BlockBegin

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
	if child_blocks[BeginPoint.PointType.COMMON_POINT] != null:
		child_blocks[BeginPoint.PointType.COMMON_POINT].zap_processing(zap)
	else:
		print("Прерывание сигнала")

	
func _on_button_pressed():
	zap_processing()
	
