extends Node2D

var GridLineScene:PackedScene = preload("res://scenes/drawing_window/drawing_field/grid_line/grid_line.tscn")

func _ready():
	GB.line_creation_wanted.connect(on_line_creation_wanted)
	GB.clear_field_wanted.connect(clear_grid_lines)
	GB.activate_all_begin_blocks_wanted.connect(clear_grid_lines)
	
func on_line_creation_wanted(zap:Zap):
	
	var old_line = find_grid_line(zap)
	while old_line != null:
		old_line.remove_myself()
		old_line = find_grid_line(zap)

	var line:GridLine = GridLineScene.instantiate() as GridLine
	line.zap = zap
	add_child(line);
	zap.grid_line = line

	
#func remove_grid_line(grid_line:GridLine):
	##for grid_line:GridLine in get_children():
		##if grid_line.block_begin == block_begin:
			##block_begin.grid_line = null
			##grid_line.queue_free()

func clear_grid_lines():
	for grid_line:GridLine in get_children():
		grid_line.remove_myself()

func find_grid_line(zap:Zap):
	for grid_line:GridLine in get_children():
		if grid_line.zap.block_begin == zap.block_begin and !grid_line.is_queued_for_deletion():
			return grid_line
	return null

