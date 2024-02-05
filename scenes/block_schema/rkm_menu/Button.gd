extends Button

@onready var Blocks = $"../../..".get_parent().get_node("Blocks")

@onready var BlockTypes = {
	"begin" :preload("res://scenes/block_schema/block/block_begin/block_begin.tscn"),
	"draw" :preload("res://scenes/block_schema/block/block_draw/block_draw.tscn"),
	"end" :preload("res://scenes/block_schema/block/block_end/block_end.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var opt = $"../OptionButton" as OptionButton
	match(opt.selected):
		0:
			var block = BlockTypes["begin"].instantiate()
			Blocks.add_child(block)
			block.position = block.get_parent().to_local(get_global_mouse_position())
		1:
			var block = BlockTypes["draw"].instantiate()
			Blocks.add_child(block)
			block.position = block.get_parent().to_local(get_global_mouse_position())
		2:
			var block = BlockTypes["end"].instantiate()
			Blocks.add_child(block)
			block.position = block.get_parent().to_local(get_global_mouse_position())
	$"../../..".hide()
	pass # Replace with function body.
