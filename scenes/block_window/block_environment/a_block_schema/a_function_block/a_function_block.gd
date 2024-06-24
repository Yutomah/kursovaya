extends ABlock
class_name AFunctionBlock

@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton
@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit

@onready var option_button: OptionButton = %OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	spawn_block_button.item_pressed.connect(on_item_pressed)
	block_type = "Блок функции"
	block_type_label.text = block_type
	pass # Replace with function body.

func get_next_block():
	return zone.get_next_block(self)
	
func send_msg_to_log(zap:Zap):
	var func_name = option_button.block_begin_array[option_button.selected].block_name
	
	var msg = "%s: выполнение функции с именем %s началось" % [block_type, func_name]
	zap.log_group.write_record(msg, self)
	
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		if option_button.selected != -1:
			zap.return_stack.append(get_next_block())
			option_button.block_begin_array[option_button.selected].arg_zap_processing(zap)
		else:
			error_no_selected_begin_block(zap)

#region saving
func serialize():
	var dict = {
		"type":block_type,
		"func":option_button.current_block
	}
	return dict	

func deserialize(dict):
	await GB.load_ended
	option_button.current_block = GB.id_map[dict["func"]]
	option_button.update_options()
	
#endregion
			
#region Alignment
func delete_me():
	queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)

func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
#endregion
