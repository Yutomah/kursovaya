extends Node2D

var grid_size:int = 32

func draw_color_line(from: Vector2, direction :Vector2, color: Color):
	var line = Line2D.new() 
	line.points = PackedVector2Array([from, from + direction * grid_size])
	line.width = 1
	line.default_color = color
	$Lines.add_child(line)
	return
	
func _ready():
	draw_color_line(Vector2(100, 100), Vector2.LEFT, Color(0.5, 0.9, 0.1))
