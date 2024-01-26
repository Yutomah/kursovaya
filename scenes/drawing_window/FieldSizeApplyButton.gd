extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	print($"../InfiniteGridCheckBox".button_pressed)
	if $"../InfiniteGridCheckBox".button_pressed:
		GB.change_field_size_wanted.emit($"../InfiniteGridCheckBox".button_pressed, Vector2i(-1,-1))
	else:
		var grid_size = Vector2i(int($"../WidthContainer/WidthLineEdit".value),\
		int($"../HeightContainer/HeightLineEdit".value) )
		GB.change_field_size_wanted.emit($"../InfiniteGridCheckBox".button_pressed, grid_size)
