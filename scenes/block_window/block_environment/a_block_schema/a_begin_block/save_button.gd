extends Button


@onready var name_line_edit: LineEdit = %NameLineEdit
@export var a_begin_block:ABeginBlock
func _ready():
	pass
	
func _on_pressed() -> void:
	if name_line_edit.text != "":
		pass
		GB.loader.save_blocks(GB.loader.single_serialize(GB.get_my_begin_zone(a_begin_block)), name_line_edit.text)
