extends Node2D

var GridLineScene:PackedScene = preload("res://scenes/drawing_window/drawing_field/grid_line/grid_line.tscn")
func _ready():
	GB.line_creation_wanted.connect(on_line_creation_wanted)
	
func on_line_creation_wanted(block_begin:BlockBegin):
	var line:GridLine = GridLineScene.instantiate() as GridLine
	line.block_begin = block_begin
	add_child(line);
