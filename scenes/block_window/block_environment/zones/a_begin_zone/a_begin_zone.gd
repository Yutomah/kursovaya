extends AZone
class_name ABeginZone

@onready var a_begin_block: ABeginBlock = %ABeginBlock
@onready var a_end_block: AEndBlock = %AEndBlock

var zone_type = "ABeginZone"
## Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	GB.begin_zones.append(self)
	GB.block_begin_array_changed.emit()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		signal_propagation()
	
func signal_propagation():
	var block:ABlock = a_begin_block
	while true:
		block.a_highlight()
		await get_tree().create_timer(0.5).timeout
		block.a_dehighlight()
		await get_tree().create_timer(0.2).timeout
		
		if block is AEndBlock:
			break
		block = block.get_next_block()
		
	
func get_next_block(block):
	for i in main_list.get_child_count():
		if main_list.get_child(i) == block:
			if main_list.get_child(-1) == block:
				return zone.get_next_block(self)
			else:
				var next_block = main_list.get_child(i+1)
				if next_block is ABlock:
					return next_block
				else:
					return next_block.get_first_block()
					
func get_first_block():
	return a_begin_block

#region saving
func serialize():
	var dict = {
		"type":zone_type,
		"pos_x":position.x,
		"pos_y":position.y,
		"a_begin_block":a_begin_block.serialize(),
		"a_end_block":a_end_block.serialize(),
		"main_list":[],
	}
	
	for i in range(1, main_list.get_child_count()-1):
		dict["main_list"].append(main_list.get_child(i).serialize())
	return dict	
	
func deserialize(dict):
	position.x = dict["pos_x"]
	position.y = dict["pos_y"]
	a_begin_block.deserialize(dict["a_begin_block"])
	a_end_block.deserialize(dict["a_end_block"])
	
	for child_dict in dict["main_list"]:
		var block = get_block_from_type(child_dict["type"]).instantiate()
		spawn_block(block, -2)
		block.deserialize(child_dict)

#endregion

#region Alignment
func update_everything():
	update_alignment()
	
	rec_update_line_connections()
	update_line_connections()
		
	rec_connect_blocks()
	connect_blocks()
	pass
#endregion
