extends Node2D

var GridLineScene:PackedScene = preload("res://scenes/drawing_window/draw_environment/draw_field/grid_line/grid_line.tscn")

func _ready():
	GB.line_creation_wanted.connect(on_line_creation_wanted)
	PSM.state_changed.connect(on_state_changed)
	
func on_line_creation_wanted(zap:Zap):
	var line:GridLine = GridLineScene.instantiate() as GridLine
	add_child(line);
	zap.grid_line = line
	line.zap = zap

func clear_grid_lines():
	for grid_line:GridLine in get_children():
		grid_line.remove_myself()

func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			pass
		PSM.STATE.PAUSE:
			pass
		PSM.STATE.STOP:
			pass
		PSM.STATE.CLEAR:
			clear_grid_lines()
		
