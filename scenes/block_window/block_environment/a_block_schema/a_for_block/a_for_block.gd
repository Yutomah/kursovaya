extends ABlock
class_name AForBlock

@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton

@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit

@onready var cycle_entrance: Marker2D = %CycleEntrance
@onready var cycle_exit: Marker2D = %CycleExit


func _ready():
	super._ready()
	#custom_minimum_size = Vector2(background.size.x + GB.left_right_margin*2, background.size.y)
	#body.custom_minimum_size =  Vector2(background.size.x + GB.left_right_margin*2, background.size.y)
	
	spawn_block_button.item_pressed.connect(on_item_pressed)
	pass # Replace with function body.

func get_next_block():
	if randi() % 5 == 0:
		return zone.get_next_block_exit(self)
		
	return zone.get_next_block(self)
	

	
#region Alignment
func delete_me():
	zone.queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)

#func align_block(left_min_size:float):
	#if left_min_size == -1:
		#body.position.x = (zone.size.x - GB.left_right_margin)/2 - body.size.x/2
	#else:
		#body.position.x = left_min_size + GB.h_separation - body.size.x / 2 
#endregion
