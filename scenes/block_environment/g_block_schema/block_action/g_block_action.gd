extends GBlock
class_name GBlockAction

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint
@onready var end_point:GEndPoint = $EndPoints/GEndPoint
 
func _ready():
	super._ready()
	pass # Replace with function body.


func _process(delta):
	super._process(delta)
	pass
	
func zap_processing(zap:Zap):
	if await zap_processing_control():
		var x = $Control/MarginContainer/Content/XContainer/SpinBox.value
		var y = $Control/MarginContainer/Content/YContainer/SpinBox.value
		var direction = Vector2i(x,y)
		
		var line_drawed:bool
		if $Control/MarginContainer/Content/CheckBox.button_pressed == true:
			line_drawed = zap.grid_line.line_jump(direction)
		else:
			line_drawed = zap.grid_line.line_draw(direction)
			
		if line_drawed:
			if begin_point.end_point != null:
				begin_point.end_point.block.zap_processing(zap)
			else:
				print("Отсутствует блок для последующей передачи")
		else:
			print("Нарушение границ доски")

