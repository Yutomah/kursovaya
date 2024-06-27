extends ColorPickerButton

@export var a_begin_block:ABeginBlock
@onready var color_rect: ColorRect = %ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_color_changed(color: Color) -> void:
	self.color = color
	color_rect.color = color
	a_begin_block.pencil_color = color
