extends AZone
class_name ABeginZone

## Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	GB.begin_zones.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_everything():
	update_alignment()
	
	rec_update_line_connections()
	update_line_connections()
		
	rec_connect_blocks()
	connect_blocks()
