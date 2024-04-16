extends GBlock
class_name GBlockEnd

@onready var end_point:GEndPoint = $EndPoints/GEndPoint

func _ready():
	super._ready()
	pass # Replace with function body.


func _process(delta):
	super._process(delta)
	pass

func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		zap.log_group.write_record(block_name, self)
		if zap.return_stack.size() > 0:
			var return_block:GBlock = zap.return_stack.pop_back()
			if return_block != null:
				return_block.zap_processing(zap)
			else:
				error_next_block_not_exist(zap)
		else:
			remove_from_group("working_blocks")
			PSM.process_input(PSM.INPUT.LSTOP)
