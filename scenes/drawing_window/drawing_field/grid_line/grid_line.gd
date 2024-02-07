extends Node2D
class_name GridLine

var block_begin:BlockBegin = null
var CELL_SIZE:int
var color:Color = Color.WHITE
@onready var grid = get_parent().get_parent()

@onready var current_line:Line2D = $Line2D
var current_grid_pos:Vector2i = Vector2i.ZERO

func _ready():
	CELL_SIZE = get_parent().get_parent().CELL_SIZE
	

func line_draw(direction:Vector2i):
	if can_draw(current_grid_pos + direction):
		current_grid_pos += direction
		current_line.add_point(current_grid_pos * CELL_SIZE)
		return true
	return false
	
func line_jump(direction:Vector2i):
	if can_draw(current_grid_pos + direction):
		current_grid_pos += direction
		var new_pos:Vector2i = current_grid_pos * CELL_SIZE
		
		var new_line:Line2D = Line2D.new()
		new_line.points = PackedVector2Array([new_pos])
		new_line.width = 3
		add_child(new_line)
		current_line = new_line
		return true
	return false

func can_draw(current_grid_pos):
	var in_borders_x = current_grid_pos.x <= grid.grid_size.x and current_grid_pos.x >= 0
	var in_borders_y = current_grid_pos.y <= grid.grid_size.y and current_grid_pos.y >= 0
	var result = (in_borders_x and in_borders_y and !grid.is_inf_grid) or grid.is_inf_grid
	GB.line_draw_ended.emit(result)
	return result
	
func remove_myself():
	block_begin.grid_line = null
	queue_free()
	
func _process(delta):
	pass
