extends ABlock
class_name AIfBlock

@onready var if_zone:AIfZone2 = get_node("../../../")
@export var left:SpawnBlockButton
@export var right:SpawnBlockButton

func _ready():
	left.item_pressed.connect(on_left_pressed)
	right.item_pressed.connect(on_right_pressed)
	super._ready()


func on_left_pressed(ablock):
	print("left")
	if_zone.spawn_left(ablock)
	
func on_right_pressed(ablock):
	print("right")
	if_zone.spawn_right(ablock)


