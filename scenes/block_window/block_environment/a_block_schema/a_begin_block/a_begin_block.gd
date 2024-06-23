extends ABlock
class_name ABeginBlock

@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton
@onready var exit: Marker2D = %Exit


func _ready():
	super._ready()
	spawn_block_button.item_pressed.connect(on_item_pressed)
	pass # Replace with function body.


#region Alignment
func delete_me():
	var my_zone = GB.get_my_begin_zone(self)
	GB.begin_zones.erase(my_zone)
	my_zone.queue_free()
	
	
func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
#endregion
