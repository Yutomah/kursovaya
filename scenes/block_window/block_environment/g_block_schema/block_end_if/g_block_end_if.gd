extends GBlock

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint

@onready var end_point:GEndPoint = $EndPoints/GEndPoint
@onready var end_point2:GEndPoint = $EndPoints/GEndPoint2


func _ready():
	super._ready()


func _process(delta):
	super._process(delta)
	
	
func send_msg_to_log(zap:Zap):
	var msg  = "%s" % block_name
	zap.log_group.write_record(msg, self)
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		
		if begin_point.end_point != null:
				begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist(zap)

func  serialize():
	var dict = super.serialize()
	
	dict["end_point"] = end_point
	dict["end_point2"] = end_point2
	dict["begin_point"] = begin_point
	dict["link"] = begin_point.end_point
	return dict
	
func deserialize(dict, id_map):
	super.deserialize(dict, id_map)
	if id_map[dict["link"]] != null:
		begin_point.create_link(id_map[dict["link"]])

func map_point_id(id_map, dict):
	super.map_point_id(id_map, dict)
	id_map[dict["end_point"]] = end_point
	id_map[dict["end_point2"]] = end_point2
	id_map[dict["begin_point"]] = begin_point
	
