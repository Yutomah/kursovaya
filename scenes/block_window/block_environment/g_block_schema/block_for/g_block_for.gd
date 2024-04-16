extends GBlock
class_name GBlockFor

@onready var end_point:GEndPoint = $EndPoints/GEndPoint
@onready var end_point_cycle:GEndPoint = $EndPoints/GEndPoint2
@onready var false_point:GBeginPoint = $BeginPoints/GBeginPoint
@onready var true_point:GBeginPoint = $BeginPoints/GBeginPoint2


var counter = 0

func _ready():
	PSM.state_changed.connect(on_state_changed)
	super._ready()
	pass # Replace with function body.
	
	
func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			counter = 0

func _process(delta):
	super._process(delta)
	pass

func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		zap.log_group.write_record(block_name, self)
		
		if counter < $Control/MarginContainer/Content/IterAmountContainer/SpinBox.value:
			if true_point.end_point != null:
				counter += 1
				true_point.end_point.block.zap_processing(zap)
			else:
				error_next_block_not_exist(zap)
		else:
			if false_point.end_point != null:
				false_point.end_point.block.zap_processing(zap)
			else:
				error_next_block_not_exist(zap)
