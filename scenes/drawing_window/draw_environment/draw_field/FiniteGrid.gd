extends Node2D


@onready var CELL_SIZE = $"..".CELL_SIZE
var grid_size:Vector2i = Vector2i(10,10)
var line_width = 1

func _ready():
	GB.camera_to_default_wanted.connect(on_camera_to_default_wanted)
	GB.camera_zoom_to.connect(on_camera_zoom_to)
	
func on_camera_to_default_wanted(window_type):
	if window_type == GB.WIN_TYPE.DRAW_WINDOW:
		line_width = 1
		queue_redraw()
	
func on_camera_zoom_to(zoom_value, window_type):
	if window_type == GB.WIN_TYPE.DRAW_WINDOW:
		line_width = 1/zoom_value
		queue_redraw()
	
func _draw():
	draw_finite_grid(CELL_SIZE, grid_size, line_width)
	draw_border(CELL_SIZE, grid_size, 1)
	
func draw_finite_grid(cell_size:int, cell_amount: Vector2i, width:float, color:Color = Color.DARK_GRAY):
	var begin_grid = Vector2i.ZERO
	var end_grid = cell_amount * cell_size
	
	for i in range(cell_amount.x):
		var begin_line = Vector2(begin_grid.x + i * cell_size, begin_grid.y)
		var end_line = Vector2(begin_grid.x + i * cell_size, end_grid.y)
		draw_line(begin_line, end_line, color, width)
	for i in range(cell_amount.y):
		var begin_line = Vector2(begin_grid.x, begin_grid.y + cell_size * i)
		var end_line = Vector2(end_grid.x, begin_grid.y + cell_size * i)
		draw_line(begin_line, end_line, color, width)
		
func draw_border(cell_size:int, cell_amount: Vector2i, width:float, color:Color = Color.GRAY):
	var begin_grid = Vector2i.ZERO
	var end_grid = cell_amount * cell_size
	
	draw_line(begin_grid, Vector2i(end_grid.x, begin_grid.y), color, width)
	draw_line(begin_grid, Vector2i(begin_grid.x, end_grid.y), color, width)
	draw_line(Vector2i(begin_grid.x, end_grid.y), end_grid, color, width)
	draw_line(Vector2i(end_grid.x, begin_grid.y), end_grid, color, width)
