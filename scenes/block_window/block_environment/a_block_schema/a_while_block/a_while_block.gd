extends ABlock
class_name AWhileBlock


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

#region Alignment
func delete_me():
	zone.queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
#endregion
