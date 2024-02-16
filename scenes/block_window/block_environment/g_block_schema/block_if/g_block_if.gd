extends GBlock
class_name GBlockIf

@onready var end_point:GEndPoint = $EndPoints/GEndPoint
@onready var false_point:GBeginPoint = $BeginPoints/GBeginPoint
@onready var true_point:GBeginPoint = $BeginPoints/GBeginPoint2

func _ready():
	super._ready()
	pass # Replace with function body.


func _process(delta):
	super._process(delta)
	pass

func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		var x_dir = $Control/MarginContainer/Content/XContainer/XSpinBox.value
		var y_dir = $Control/MarginContainer/Content/YContainer/YSpinBox.value
		var direction = Vector2i(x_dir,y_dir)
		var distance = $"Control/MarginContainer/Content/Distance container/DistanceSpinBox".value
		
		if zap.grid_line.check_for_border(direction, distance):
			if true_point.end_point != null:
				true_point.end_point.block.zap_processing(zap)
			else:
				error_next_block_not_exist()
		else:
			if false_point.end_point != null:
				false_point.end_point.block.zap_processing(zap)
			else:
				error_next_block_not_exist()
