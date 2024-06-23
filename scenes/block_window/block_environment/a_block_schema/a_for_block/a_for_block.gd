extends ABlock
class_name AForBlock

@export var spawn_block_button:SpawnBlockButton

func _ready():
	super._ready()
	#custom_minimum_size = Vector2(background.size.x + GB.left_right_margin*2, background.size.y)
	#body.custom_minimum_size =  Vector2(background.size.x + GB.left_right_margin*2, background.size.y)
	
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

func align_block(left_min_size:float):
	if left_min_size == -1:
		body.position.x = (zone.size.x - GB.left_right_margin)/2 - body.size.x/2
	else:
		body.position.x = left_min_size + GB.h_separation/2 - body.size.x / 2 
