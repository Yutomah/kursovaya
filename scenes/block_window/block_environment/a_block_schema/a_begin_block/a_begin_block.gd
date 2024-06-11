extends ABlock
class_name ABeginBlock

@export var spawn_block_button:SpawnBlockButton


func _ready():
	super._ready()
	spawn_block_button.item_pressed.connect(on_item_pressed)
	pass # Replace with function body.



func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
