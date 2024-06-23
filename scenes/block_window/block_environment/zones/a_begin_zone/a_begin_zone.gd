extends AZone
class_name ABeginZone

@onready var a_begin_block: ABeginBlock = %ABeginBlock
@onready var a_end_block: AEndBlock = %AEndBlock

## Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	GB.begin_zones.append(self)


func get_first_block():
	return a_begin_block


#region Alignment
func update_everything():
	update_alignment()
	
	rec_update_line_connections()
	update_line_connections()
		
	rec_connect_blocks()
	connect_blocks()
#endregion
