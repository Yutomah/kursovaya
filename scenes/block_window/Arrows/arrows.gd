extends HBoxContainer
class_name Arrows

var selected:int = 0:
	set(value):
		$Direction.selected = value
		
func get_direction()->Vector2:
	match($Direction.selected):
		0:
			return Vector2(0,-1)
		1:
			return Vector2(1, -1)
		2:
			return Vector2(1,0)
		3:
			return Vector2(1,1)
		4:
			return Vector2(0, 1)
		5:
			return Vector2(-1, 1)
		6:
			return Vector2(-1, 0)
		7:
			return Vector2(-1,-1)
	
	return Vector2.ZERO


func _on_direction_item_selected(index):
	selected = index
