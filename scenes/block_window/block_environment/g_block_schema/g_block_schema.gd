extends Node2D

var begin_block_array:Array[GBlockBegin]

func _ready():
	GB.block_name_changed.connect(update_begin_block_array)
	update_begin_block_array()
	
func update_begin_block_array():
	begin_block_array = []
	for block in get_children():
		if block is GBlockBegin:
			begin_block_array.append(block)
	GB.block_begin_array_changed.emit(begin_block_array)
	pass



