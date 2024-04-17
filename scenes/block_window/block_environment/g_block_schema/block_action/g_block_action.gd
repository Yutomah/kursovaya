extends GBlock
class_name GBlockAction

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint
@onready var end_point:GEndPoint = $EndPoints/GEndPoint
 
func _ready():
	super._ready()


func _process(delta):
	super._process(delta)
	
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		zap.log_group.write_record(block_name, self)
		
		var direction = $Control/MarginContainer/Content/DirectionContainer.get_direction()
		
		var line_drawed:bool
		if $Control/MarginContainer/Content/CheckBox.button_pressed == true:
			line_drawed = zap.grid_line.line_jump(direction)
		else:
			line_drawed = zap.grid_line.line_draw(direction)
			
		if line_drawed:
			if begin_point.end_point != null:
				begin_point.end_point.block.zap_processing(zap)
			else:
				error_next_block_not_exist(zap)
		else:
			error_line_beyond_borders(zap)

