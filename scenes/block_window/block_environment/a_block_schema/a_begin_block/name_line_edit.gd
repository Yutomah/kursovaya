extends LineEdit

@export var a_begin_block:ABeginBlock

@onready var name_label: Label = %NameLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	a_begin_block.block_name = text
	name_label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_text_changed(new_text: String) -> void:
	a_begin_block.block_name = new_text
	name_label.text = new_text
	GB.block_begin_array_changed.emit()
