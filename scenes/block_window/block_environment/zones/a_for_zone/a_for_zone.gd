extends AZone
class_name AForZone

var left_side:float
var right_side:float
var cycle_depth:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	#add_theme_constant_override("margin_left", GB.left_right_margin)
	#add_theme_constant_override("margin_right", GB.left_right_margin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_cycle_depth():
	var depth = 0
	for child in main_list.get_children():
		if child is AForZone:
			var t = get_cycle_depth()
			if t > depth:
				depth = t
				
	return depth + 1
			

func get_max_left_right_min_size():
	var left:float = -1
	var right:float = -1

	
	for child in main_list.get_children():
		if child is AForZone:
			var left_right = child.get_max_left_right_min_size()
				
			if left < left_right[0]:
				left = left_right[0]
			
			if right < left_right[1]:
				right = left_right[1]
			
		if "zone_type" in child and child.zone_type == "AIf":
			if left < child.get_left_size().x:
				left = child.get_left_size().x
				
			if right < child.get_right_size().x:
				right = child.get_right_size().x
	
	
	left_side = left
	right_side = right
	cycle_depth = self.get_cycle_depth()
	
	return [left, right]
