class_name Zap

var grid_line:GridLine = null
var a_begin_block:ABeginBlock = null
var return_stack:Array[ABlock]
var log_group:LogGroup = null
#var for_counters:Dictionary = {}


func remove_myself():
	a_begin_block.zap = null
	if grid_line != null and !grid_line.is_queued_for_deletion():
		grid_line.remove_myself()
	if grid_line != null and !log_group.is_queued_for_deletion():
		log_group.remove_myself()
