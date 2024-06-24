extends OptionButton

@onready var function_name_label: Label = %FunctionNameLabel

var block_begin_array:Array[ABeginBlock]
var current_block:ABeginBlock = null

func _ready():
	GB.block_begin_array_changed.connect(update_options)
	update_options()
	
func update_options():
	clear()
	block_begin_array = []
	
	for zone in GB.begin_zones:
		block_begin_array.append(zone.a_begin_block)
	
	for i in range(block_begin_array.size()):
		add_item(block_begin_array[i].block_name, i)
	
	if block_begin_array.find(current_block) == -1:
		selected = -1
		current_block = null
	else:
		selected = block_begin_array.find(current_block)
	
	update_display()
	

func _on_item_selected(index):
	current_block = block_begin_array[index]
	update_display()

func update_display():
	if current_block == null:
		function_name_label.text = "---"
	else:
		function_name_label.text = current_block.block_name
