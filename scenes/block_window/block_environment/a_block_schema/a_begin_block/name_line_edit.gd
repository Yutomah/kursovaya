extends LineEdit

@export var a_begin_block:ABeginBlock
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_text_changed(new_text: String) -> void:
	a_begin_block.block_name = new_text
	GB.block_begin_array_changed.emit()
