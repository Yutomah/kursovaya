extends OptionButton

var block_begin_array:Array[GBlockBegin]

func _ready():
	GB.block_begin_array_changed.connect(update_options)
	GB.block_name_changed.emit()
	
func update_options(block_array:Array[GBlockBegin]):
	clear()
	block_begin_array = block_array
	for i in range(block_array.size()):
		add_item(block_array[i].block_name, i)
