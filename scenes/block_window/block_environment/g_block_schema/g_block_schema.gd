extends Node2D

var begin_block_array:Array[GBlockBegin]
func _ready():
	GB.block_name_changed.connect(update_begin_block_array)
	GB.block_amount_wanted.connect(on_block_amount_wanted)
	print(get_child_count())
	update_begin_block_array()
	
func update_begin_block_array():
	begin_block_array = []
	for block in get_children():
		if block is GBlockBegin:
			begin_block_array.append(block)
	GB.block_begin_array_changed.emit(begin_block_array)
	pass



func _on_child_entered_tree(node):
	GB.block_amount_changed.emit(get_child_count())


func _on_child_exiting_tree(node):
	GB.block_amount_changed.emit(get_child_count())

func on_block_amount_wanted():
	GB.block_amount_changed.emit(get_child_count())
