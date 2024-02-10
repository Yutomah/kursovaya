extends MarginContainer


@onready var block_schema = $"../SubViewport/GBlockSchema"
@onready var BlockTypes = {
	"begin" :preload("res://scenes/block_environment/g_block_schema/block_begin/g_block_begin.tscn"),
	"action" :preload("res://scenes/block_environment/g_block_schema/block_action/g_block_action.tscn"),
	"if": preload("res://scenes/block_environment/g_block_schema/block_if/g_block_if.tscn"),
	"join":preload("res://scenes/block_environment/g_block_schema/block_join/g_block_join.tscn"),
	"end" :preload("res://scenes/block_environment/g_block_schema/block_end/g_block_end.tscn")
}

func _input(event):
	if (event.is_action_pressed("LKM") or event.is_action_pressed("RKM")):
		if visible and !get_rect().has_point(get_parent().get_local_mouse_position()):
			close_context_menu()
	
func _on_button_pressed():
	var opt = $VBoxContainer/HBoxContainer/OptionButton as OptionButton
	match(opt.selected):
		0:
			var block = BlockTypes["begin"].instantiate()
			block_schema.add_child(block)
			block.position = block.get_parent().get_local_mouse_position()
		1:
			var block = BlockTypes["action"].instantiate()
			block_schema.add_child(block)
			block.position = block.get_parent().to_local(get_global_mouse_position())
		2:
			var block = BlockTypes["if"].instantiate()
			block_schema.add_child(block)
			block.position = block.get_parent().to_local(get_global_mouse_position())
		3:
			var block = BlockTypes["join"].instantiate()
			block_schema.add_child(block)
			block.position = block.get_parent().to_local(get_global_mouse_position())
		4:
			var block = BlockTypes["end"].instantiate()
			block_schema.add_child(block)
			block.position = block.get_parent().to_local(get_global_mouse_position())
	close_context_menu()
	
func close_context_menu():
	hide()
