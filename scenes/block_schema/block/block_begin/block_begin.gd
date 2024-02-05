extends Block
class_name BlockBegin

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func signal_processing(block_begin:BlockBegin):
	GB.line_creation_wanted.emit(self)
	if child_blocks[BeginPoint.PointType.COMMON_POINT] != null:
		child_blocks[BeginPoint.PointType.COMMON_POINT].signal_processing(block_begin)
	else:
		print("over")
	
	
func _on_button_pressed():
	signal_processing(self)
