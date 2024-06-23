extends Marker2D
class_name ArrowMarker

@export var arrow_angle:int
@export var arrow_enabled:bool = false
func _draw() -> void:
	if arrow_enabled:
		draw_line(Vector2.ZERO, Vector2(-10, 5), GB.line_color, GB.line_width)
		draw_line(Vector2.ZERO, Vector2(-10, -5), GB.line_color, GB.line_width)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	rotation_degrees = arrow_angle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
