extends CheckBox



func _on_toggled(toggled_on):
	$"../WidthContainer/WidthLineEdit".editable = not toggled_on
	$"../HeightContainer/HeightLineEdit".editable = not toggled_on
