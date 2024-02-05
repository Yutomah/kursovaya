extends Node2D
class_name GridLine

var block_begin:BlockBegin = null
var CELL_SIZE:int
var color:Color = Color.WHITE
@onready var current_line:Line2D = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GB.line_draw_wanted.connect(on_line_draw_wanted)
	GB.line_jump_wanted.connect(on_line_jump_wanted)
	CELL_SIZE = get_parent().get_parent().CELL_SIZE
	

func on_line_draw_wanted(block_begin:BlockBegin, direction:Vector2):
	if self.block_begin == block_begin:
		current_line.add_point(current_line.points[-1] + direction * CELL_SIZE)
		
func on_line_jump_wanted(block_begin:BlockBegin, direction:Vector2):
	if self.block_begin == block_begin:
		var new_pos:Vector2 = current_line.points[-1] + direction * CELL_SIZE
		var new_line:Line2D = Line2D.new()
		new_line.points = PackedVector2Array([new_pos])
		new_line.width = 3
		add_child(new_line)
		current_line = new_line
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
