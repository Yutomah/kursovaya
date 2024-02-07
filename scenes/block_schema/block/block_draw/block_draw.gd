extends Block
class_name BlockDraw

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func signal_processing(block_begin:BlockBegin):
	await get_tree().create_timer(0.3).timeout
	var x = $VBoxContainer/XContainer/SpinBox.value
	var y = $VBoxContainer/YContainer/SpinBox.value
	var direction = Vector2i(x,y)
	
	var line_drawed:bool
	if $VBoxContainer/CheckBox.button_pressed == true:
		line_drawed = block_begin.grid_line.line_jump(direction)
	else:
		line_drawed = block_begin.grid_line.line_draw(direction)
		
	if line_drawed:
		if child_blocks[BeginPoint.PointType.COMMON_POINT] != null:
			child_blocks[BeginPoint.PointType.COMMON_POINT].signal_processing(block_begin)
		else:
			print("Отсутствует блок для последующей передачи")
	else:
		print("Нарушение границ доски")

