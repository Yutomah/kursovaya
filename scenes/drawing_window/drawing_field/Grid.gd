extends Node2D

const CELL_SIZE:int = 32
var grid_size:Vector2i

var is_inf_grid:bool = true:
	set(value):
		is_inf_grid = value
		if value:
			$InfiniteGrid.show()
			$FiniteGrid.hide()
		else:
			$InfiniteGrid.hide()
			$FiniteGrid.queue_redraw()
			$FiniteGrid.show()
			grid_size = $FiniteGrid.grid_size

func on_change_field_size_wanted(is_inf_grid:bool, grid_size:Vector2i):
	if not is_inf_grid:
		$FiniteGrid.grid_size = grid_size
	self.is_inf_grid = is_inf_grid
		
func _ready():
	GB.change_field_size_wanted.connect(on_change_field_size_wanted)
	
func _process(delta):
	if is_inf_grid:
		var grid_x = int($"../Camera2D".offset.x / CELL_SIZE) * CELL_SIZE
		var grid_y = int($"../Camera2D".offset.y / CELL_SIZE) * CELL_SIZE
		$InfiniteGrid.position = Vector2(grid_x, grid_y)
		
func _draw():
	draw_circle(Vector2.ZERO, 5, Color.DARK_GRAY)
