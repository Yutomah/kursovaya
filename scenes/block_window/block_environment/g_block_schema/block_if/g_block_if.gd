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
		zap.log_group.write_record(block_name, self)
		
		var direction = $Control/MarginContainer/Content/Arrows.get_direction()
		var distance = $"Control/MarginContainer/Content/Distance container/DistanceSpinBox".value
		
		if zap.grid_line.check_for_border(direction, distance):
			if true_point.end_point != null:
				true_point.end_point.block.zap_processing(zap)
			else:
				error_next_block_not_exist(zap)
		else:
			if false_point.end_point != null:
				false_point.end_point.block.zap_processing(zap)
			else:
				error_next_block_not_exist(zap)
				
func  serialize():
	var dict = super.serialize()
	dict["false_point"] = false_point
	dict["true_point"] = true_point
	dict["end_point"] = end_point
	dict["distance"] = $"Control/MarginContainer/Content/Distance container/DistanceSpinBox".value
	dict["direction"] = $Control/MarginContainer/Content/Arrows.selected
	
	dict["link_true"] = true_point.end_point
	dict["link_false"] = false_point.end_point
	return dict

func deserialize(dict, id_map):
	super.deserialize(dict, id_map)
	false_point = id_map[dict["false_point"]] 
	true_point = id_map[dict["true_point"]]  
	end_point = id_map[dict["end_point"]]  
	$"Control/MarginContainer/Content/Distance container/DistanceSpinBox".value = dict["distance"]  
	$Control/MarginContainer/Content/Arrows.selected = dict["direction"]  
	
	if id_map[dict["link_true"]] != null:
		true_point.create_link(id_map[dict["link_true"]])
	if id_map[dict["link_false"]] != null:
		false_point.create_link(id_map[dict["link_false"]])

func map_point_id(id_map, dict):
	super.map_point_id(id_map, dict)
	id_map[dict["false_point"]] = false_point
	id_map[dict["true_point"]] = true_point
	id_map[dict["end_point"]] = end_point 
