class_name Zap

var grid_line:GridLine = null
var block_begin:GBlockBegin = null
var return_stack:Array[GBlock]

func clone()->Zap:
	var new_zap:Zap = Zap.new()
	new_zap.block_begin = block_begin
	new_zap.grid_line = grid_line.clone(new_zap)
	return new_zap
