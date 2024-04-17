extends GBlock
class_name GBlockFunction

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint
@onready var end_point:GEndPoint = $EndPoints/GEndPoint

func _ready():
	super._ready()
	$Control/MarginContainer/Content/OptionButton

func _process(delta):
	super._process(delta)
	
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		zap.log_group.write_record(block_name, self)
		if %OptionButton.selected != -1:
			if begin_point.end_point != null:
				zap.return_stack.append(begin_point.end_point.block)
			else:
				zap.return_stack.append(null)
			%OptionButton.block_begin_array[%OptionButton.selected].arg_zap_processing(zap)
		else:
			error_no_selected_begin_block(zap)

func  serialize():
	var dict = super.serialize()
	dict["begin_point"] = begin_point
	dict["end_point"] = end_point
	dict["func"] = null if %OptionButton.selected == -1 \
		else %OptionButton.block_begin_array[%OptionButton.selected]
	
	dict["link"] = begin_point.end_point
	
	return dict
	
func deserialize(dict, id_map):
	super.deserialize(dict, id_map)
	
	#dict["func"] null if %OptionButton.selected == -1 \
		#else %OptionButton.block_begin_array[%OptionButton.selected]
	
	if id_map[dict["link"]] != null:
		begin_point.create_link(id_map[dict["link"]])
	
	

func map_point_id(id_map, dict):
	id_map[dict["end_point"]] = end_point
	id_map[dict["begin_point"]] = begin_point
