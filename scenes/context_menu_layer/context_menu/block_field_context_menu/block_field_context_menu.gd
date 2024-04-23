extends ContextMenu
class_name BlockFieldContextMenu

var block_schema

@onready var BlockTypes = {
	"begin" :preload("res://scenes/block_window/block_environment/g_block_schema/block_begin/g_block_begin.tscn"),
	"action":preload("res://scenes/block_window/block_environment/g_block_schema/block_action/g_block_action.tscn"),
	"if": preload("res://scenes/block_window/block_environment/g_block_schema/block_if/g_block_if.tscn"),
	"end_if": preload("res://scenes/block_window/block_environment/g_block_schema/block_end_if/g_block_end_if.tscn"),
	"while":preload("res://scenes/block_window/block_environment/g_block_schema/block_while/g_block_while.tscn"),
	"for":preload("res://scenes/block_window/block_environment/g_block_schema/block_for/g_block_for.tscn"),
	"end" :preload("res://scenes/block_window/block_environment/g_block_schema/block_end/g_block_end.tscn"),
	"func" :preload("res://scenes/block_window/block_environment/g_block_schema/block_function/g_block_function.tscn")
}

func _on_button_pressed():
	var opt = $VBoxContainer/HBoxContainer/OptionButton as OptionButton
	var block
	match(opt.selected):
		0:
			block = BlockTypes["begin"].instantiate()
		1:
			block = BlockTypes["action"].instantiate()
		2:
			block = BlockTypes["if"].instantiate()
		3:
			block = BlockTypes["end_if"].instantiate()
		4:
			block = BlockTypes["while"].instantiate()
		5:
			block = BlockTypes["for"].instantiate()
		6: 
			block = BlockTypes["func"].instantiate()
		7: 
			block = BlockTypes["end"].instantiate()
	block.position = block_schema.get_local_mouse_position()-size/2
	block_schema.add_child(block)
	close_context_menu()
