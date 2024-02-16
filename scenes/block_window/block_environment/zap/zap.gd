class_name Zap

var grid_line:GridLine = null
var block_begin:GBlockBegin = null
var return_stack:Array[GBlock]

func remove_myself():
	block_begin.zap = null
	grid_line.remove_myself()
