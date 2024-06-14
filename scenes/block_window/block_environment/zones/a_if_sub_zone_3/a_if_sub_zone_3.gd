extends AZone
class_name AIfSubZone3

@export_enum("left_sub_zone", "right_sub_zone") var zone_type

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	init_zone_type()
	
func init_zone_type():
	assert(zone_type != null)
	
	if zone_type == "left_sub_zone":
		main_list.size_flags_horizontal = Control.SIZE_SHRINK_END
		return
	
	if zone_type == "right_sub_zone":
		main_list.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		return
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_main_list_size():
	return main_list.size
