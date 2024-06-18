extends ABlock
class_name AForBlock

@export var spawn_block_button:SpawnBlockButton

func _ready():
	super._ready()
	spawn_block_button.item_pressed.connect(on_item_pressed)
	pass # Replace with function body.

func delete_me():
	zone.queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_alignment)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
