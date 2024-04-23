extends CheckBox



func _on_pressed():
	if button_pressed:
		$"../StepButton".disabled = false
		GB.is_step_by_step = true
	else:
		$"../StepButton".disabled = true
		GB.is_step_by_step = false
