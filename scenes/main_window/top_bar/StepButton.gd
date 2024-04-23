extends Button



func _on_pressed():
	if GB.is_step_by_step:
		var move_next = true
		for block in get_tree().get_nodes_in_group("working_blocks"):
			if !block.is_stepped:
				move_next = false
				
		if move_next:
			GB.make_step.emit()
