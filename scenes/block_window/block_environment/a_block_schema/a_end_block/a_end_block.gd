extends ABlock
class_name AEndBlock

@onready var entrance: Marker2D = %Entrance

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	block_type = "Конечный блок"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func send_msg_to_log(zap:Zap):
	var result = zap.return_stack.size() > 0
	var msg
	if result:
		msg = "%s: функция завершена" % block_type
	else:
		msg = "%s: программа завершена" % block_type
	zap.log_group.write_record(msg, self)

func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		if zap.return_stack.size() > 0:
			var return_block:ABlock = zap.return_stack.pop_back()
			return_block.zap_processing(zap)
		else:
			zap.a_begin_block.remove_from_group("working_blocks")
			PSM.process_input(PSM.INPUT.LSTOP)
			
#region Alignment
func delete_me():
	var my_zone = GB.get_my_begin_zone(self)
	GB.begin_zones.erase(my_zone)
	my_zone.queue_free()
#endregion
