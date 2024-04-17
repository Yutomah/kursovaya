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

func  serialize():
	
	var dict = super.serialize()
	dict["iter_amount"] = $Control/MarginContainer/Content/IterAmountContainer/SpinBox.value
	dict["end_point"] = end_point
	dict["end_point_cycle"] = end_point_cycle
	dict["false_point"] = false_point
	dict["true_point"] = true_point
	
	dict["link_true"] = true_point.end_point
	dict["link_false"] = false_point.end_point
	return dict

func deserialize(dict, id_map):
	super.deserialize(dict, id_map)
	$Control/MarginContainer/Content/IterAmountContainer/SpinBox.value = dict["iter_amount"]  
	end_point = id_map[dict["end_point"]]
	end_point_cycle = id_map[dict["end_point_cycle"]]
	false_point = id_map[dict["false_point"]]
	true_point = id_map[dict["true_point"]]
	
	if id_map[dict["link_true"]] != null:
		true_point.create_link(id_map[dict["link_true"]])
	if id_map[dict["link_false"]] != null:
		false_point.create_link(id_map[dict["link_false"]])
	
func map_point_id(id_map, dict):
	id_map[dict["end_point"]] = end_point
	id_map[dict["end_point_cycle"]] = end_point_cycle
	id_map[dict["false_point"]] = false_point
	id_map[dict["true_point"]] = true_point
