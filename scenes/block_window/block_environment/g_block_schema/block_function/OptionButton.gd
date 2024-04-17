extends OptionButton

var block_begin_array:Array[GBlockBegin]
var current_block:GBlockBegin = null

func _ready():
	GB.block_begin_array_changed.connect(update_options)
	GB.block_name_changed.emit()
	
func update_options(block_array:Array[GBlockBegin]):
	clear()
	block_begin_array = block_array
	
	for i in range(block_array.size()):
		add_item(block_array[i].block_name, i)
		
	if block_begin_array.find(current_block) == -1:
		selected = -1
		current_block = null
	else:
		selected = block_begin_array.find(current_block)


func _on_item_selected(index):
	current_block = block_begin_array[index]
