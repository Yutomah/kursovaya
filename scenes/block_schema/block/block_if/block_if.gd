extends Block
class_name BlockIf

func _ready():
	super._ready()

func _process(delta):
	super._process(delta)

func zap_processing(zap:Zap):
	var x_dir = $VBoxContainer/XContainer/XSpinBox.value
	var y_dir = $VBoxContainer/YContainer/YSpinBox.value
	var direction = Vector2i(x_dir,y_dir)
	var distance = $"VBoxContainer/Distance container/DistanceSpinBox".value
	if zap.grid_line.check_for_border(direction, distance):
		if child_blocks[BeginPoint.PointType.TRUE_POINT] != null:
			child_blocks[BeginPoint.PointType.TRUE_POINT].zap_processing(zap)
		else:
			print("Отсутствует блок для последующей передачи")
	else:
		if child_blocks[BeginPoint.PointType.FALSE_POINT] != null:
			child_blocks[BeginPoint.PointType.FALSE_POINT].zap_processing(zap)
		else:
			print("Отсутствует блок для последующей передачи")
