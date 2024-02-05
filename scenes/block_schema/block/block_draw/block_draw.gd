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
	var direction = Vector2(x,y)
	if $VBoxContainer/CheckBox.button_pressed == true:
		GB.line_jump_wanted.emit(block_begin, direction)
	else:
		GB.line_draw_wanted.emit(block_begin, direction)
		
	if child_blocks[BeginPoint.PointType.COMMON_POINT] != null:
		child_blocks[BeginPoint.PointType.COMMON_POINT].signal_processing(block_begin)
	else:
		print("over")
