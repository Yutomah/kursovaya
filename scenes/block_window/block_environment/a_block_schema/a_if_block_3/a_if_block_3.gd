extends ABlock
class_name AIfBlock3

@onready var left_spawn_button: SpawnBlockButton = %LeftSpawnButton
@onready var right_spawn_button: SpawnBlockButton = %RightSpawnButton


@onready var entrance: Marker2D = %Entrance
@onready var left_exit: Marker2D = %LeftExit
@onready var right_exit: Marker2D = %RightExit

func _ready():
	left_spawn_button.item_pressed.connect(on_left_pressed)
	right_spawn_button.item_pressed.connect(on_right_pressed)
	super._ready()
	
func get_next_block():
	return zone.get_left_next_block()
	
	
	
#region Alignment
func delete_me():
	zone.queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)

func on_left_pressed(ablock):
	zone.spawn_left(ablock)
	
func on_right_pressed(ablock):
	zone.spawn_right(ablock)
#endregion
