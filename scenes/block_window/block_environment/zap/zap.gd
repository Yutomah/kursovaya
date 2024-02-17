class_name Zap

var grid_line:GridLine = null
var block_begin:GBlockBegin = null
var return_stack:Array[GBlock]
var log_group:LogGroup = null

func remove_myself():
	block_begin.zap = null
	if grid_line != null and !grid_line.is_queued_for_deletion():
		grid_line.remove_myself()
	if grid_line != null and !log_group.is_queued_for_deletion():
		log_group.remove_myself()
