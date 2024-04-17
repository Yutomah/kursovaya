extends Button



func _on_pressed():
	PSM.process_input(PSM.INPUT.CLEAR)
	if $"../InfiniteGridCheckBox".button_pressed:
		GB.change_field_size_wanted.emit($"../InfiniteGridCheckBox".button_pressed, Vector2i(-1,-1))
	else:
		var grid_size = Vector2i(int($"../WidthContainer/WidthLineEdit".value),\
		int($"../HeightContainer/HeightLineEdit".value) )
		GB.change_field_size_wanted.emit($"../InfiniteGridCheckBox".button_pressed, grid_size)
