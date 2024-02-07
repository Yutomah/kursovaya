extends Node2D

@onready var  CELL_SIZE = $"..".CELL_SIZE
const CELL_AMOUNT:int = 200


	
func _draw():
	draw_inf_grid(CELL_SIZE, CELL_AMOUNT, 1)

	
func draw_inf_grid(cell_size:int, cell_amount:int, width:float = 1, color:Color = Color.DARK_GRAY)->void:
	var begin_grid = Vector2.ONE * cell_size * cell_amount/2 * -1
	var end_grid = Vector2.ONE * cell_size * cell_amount/2
	
	for i in range(cell_amount):
		var begin_line = Vector2(begin_grid.x + i * cell_size, begin_grid.y)
		var end_line = Vector2(begin_grid.x + i * cell_size, end_grid.y)
		draw_line(begin_line, end_line, color, width)
		
		begin_line = Vector2(begin_grid.x, begin_grid.y + cell_size * i)
		end_line = Vector2(end_grid.x, begin_grid.y + cell_size * i)
		draw_line(begin_line, end_line, color, width)


	
