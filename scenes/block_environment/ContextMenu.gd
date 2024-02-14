extends MarginContainer


@onready var block_schema = $"../GBlockSchema"
@onready var BlockTypes = {
	"begin" :preload("res://scenes/block_environment/g_block_schema/block_begin/g_block_begin.tscn"),
	"action":preload("res://scenes/block_environment/g_block_schema/block_action/g_block_action.tscn"),
	"if": preload("res://scenes/block_environment/g_block_schema/block_if/g_block_if.tscn"),
	"join":preload("res://scenes/block_environment/g_block_schema/block_join/g_block_join.tscn"),
	"while":preload("res://scenes/block_environment/g_block_schema/block_while/g_block_while.tscn"),
	"end" :preload("res://scenes/block_environment/g_block_schema/block_end/g_block_end.tscn")
}

func _ready():
	GB.context_menu_close_wanted.connect(on_context_menu_close_wanted)
func _input(event):
	if (event.is_action_pressed("LKM") or event.is_action_pressed("RKM")):
		if visible and !get_rect().has_point(get_parent().get_local_mouse_position()):
			close_context_menu()
	
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
			block = BlockTypes["join"].instantiate()
		4:
			block = BlockTypes["while"].instantiate()
		5:
			block = BlockTypes["end"].instantiate()
			
	block_schema.add_child(block)
	block.position = block_schema.to_local(global_position)
	close_context_menu()
	
func on_context_menu_close_wanted():
	if visible and !get_rect().has_point(get_parent().get_local_mouse_position()):
		close_context_menu()
func close_context_menu():
	hide()
