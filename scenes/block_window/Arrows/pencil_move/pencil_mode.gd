extends OptionButton

signal pencil_selected
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_jumping():
	return selected == 1


func get_pencil_path():
	return get_item_icon(selected).resource_path


func _on_item_selected(index: int) -> void:
	pencil_selected.emit()
