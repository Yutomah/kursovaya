extends AZone
class_name AIfSubZone3

@export_enum("left_sub_zone", "right_sub_zone") var zone_type:String

@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	init_zone_type()

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
	if main_list.get_child_count() > 0:
		var block = main_list.get_child(0)
		if block is ABlock:
			return block
		else:
			return block.get_first_block()
	else:
		return null
#region Alignment
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

func update_line_connections():
	entrance.position = Vector2(GB.default_min_size.x/2, 0)
	exit.global_position = Vector2(entrance.global_position.x, global_position.y + size.y)
#endregion
