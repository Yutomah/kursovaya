extends Block
class_name BlockBegin

var grid_line:GridLine = null

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	GB.line_created.connect(on_line_created)
	GB.activate_all_begin_blocks_wanted.connect(signal_processing)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func signal_processing():
	GB.line_creation_wanted.emit(self)
	if child_blocks[BeginPoint.PointType.COMMON_POINT] != null:
		child_blocks[BeginPoint.PointType.COMMON_POINT].signal_processing(self)
	else:
		print("Прерывание сигнала")
	
func on_line_created(block_begin:BlockBegin, grid_line:GridLine):
	if block_begin == self:
		self.grid_line = grid_line

	
func _on_button_pressed():
	signal_processing()
	
