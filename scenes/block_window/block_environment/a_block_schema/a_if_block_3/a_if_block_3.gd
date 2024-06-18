extends ABlock
class_name AIfBlock3

@export var left:SpawnBlockButton
@export var right:SpawnBlockButton

func _ready():
	left.item_pressed.connect(on_left_pressed)
	right.item_pressed.connect(on_right_pressed)
	super._ready()

func delete_me():
	zone.queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_alignment)

func on_left_pressed(ablock):
	zone.spawn_left(ablock)
	
func on_right_pressed(ablock):
	zone.spawn_right(ablock)
