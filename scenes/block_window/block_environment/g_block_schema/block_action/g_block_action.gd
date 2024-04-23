extends GBlock
class_name GBlockAction

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint
@onready var end_point:GEndPoint = $EndPoints/GEndPoint
 
func _ready():
	super._ready()


func _process(delta):
	super._process(delta)

func send_msg_to_log(zap:Zap):
	var arrow_path = $Control/MarginContainer/Content/DirectionContainer.get_arrow_path()
	var msg
	if $Control/MarginContainer/Content/CheckBox.button_pressed:
		msg = "%s: Курсор перемещён в сторону [img]%s[/img]" % [block_name, arrow_path]
	else:
		msg = "%s: Линия нарисована в сторону [img]%s[/img]" % [block_name, arrow_path]
	zap.log_group.write_record(msg, self)
	
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		
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

func  serialize():
	
	var dict = super.serialize()
	
	dict["direction"] = $Control/MarginContainer/Content/DirectionContainer.selected
	dict["jump"] = $Control/MarginContainer/Content/CheckBox.button_pressed
	dict["end_point"] = end_point
	dict["begin_point"] = begin_point
	dict["link"] = begin_point.end_point
	return dict
	
func deserialize(dict, id_map):
	super.deserialize(dict, id_map)
	$Control/MarginContainer/Content/DirectionContainer.selected = dict["direction"]
	$Control/MarginContainer/Content/CheckBox.button_pressed = dict["jump"]
	if id_map[dict["link"]] != null:
		begin_point.create_link(id_map[dict["link"]])

func map_point_id(id_map, dict):
	super.map_point_id(id_map, dict)
	id_map[dict["end_point"]] = end_point
	id_map[dict["begin_point"]] = begin_point
