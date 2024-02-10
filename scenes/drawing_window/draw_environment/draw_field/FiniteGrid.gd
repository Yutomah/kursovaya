extends Node2D


@onready var CELL_SIZE = $"..".CELL_SIZE
var grid_size:Vector2i = Vector2i(10,10)

func _draw():
	draw_finite_grid(CELL_SIZE, grid_size, 1)
	draw_border(CELL_SIZE, grid_size, 4)
	
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
		
func draw_border(cell_size:int, cell_amount: Vector2i, width:float, color:Color = Color.DARK_RED):
	var begin_grid = Vector2i.ZERO
	var end_grid = cell_amount * cell_size
	
	draw_line(begin_grid, Vector2i(end_grid.x, begin_grid.y), color, width)
	draw_line(begin_grid, Vector2i(begin_grid.x, end_grid.y), color, width)
	draw_line(Vector2i(begin_grid.x, end_grid.y), end_grid, color, width)
	draw_line(Vector2i(end_grid.x, begin_grid.y), end_grid, color, width)
