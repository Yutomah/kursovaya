extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_jumping():
	return selected == 1


func get_pencil_path():
	return $Direction.get_item_icon($Direction.selected).resource_path
