extends Control
class_name Block

var LKM_pressed:bool = false
var old_mouse_position:Vector2



var parent_block:Block = null:
	set(value):
		parent_block = value
		if value != null:
			$VBoxContainer/Parent.text = value.name
		else:
			$VBoxContainer/Parent.text = "null"

var parent_blocks:Dictionary
var child_blocks:Dictionary

#var child_block:Block = null:
	#set(value):
		#child_block = value
		#if value != null:
			#$VBoxContainer/Child.text = value.name
		#else:
			#$VBoxContainer/Child.text = "null"

# Called when the node enters the scene tree for the first time.
func _ready():
	GB.focus_window = GB.BLOCK_SCHEMA
	$VBoxContainer/Me.text = self.name
	init_parent_child_blocks_dict()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if LKM_pressed:
		var dif = get_local_mouse_position() - old_mouse_position
		position += dif
		
		for begin_point in $BeginPoints.get_children():
			if begin_point.end_point != null:
				begin_point.get_node("Line2D").points[1] -= dif
		
		for end_point in $EndPoints.get_children():
			if end_point.begin_point != null:
				end_point.begin_point.get_node("Line2D").points[1] += dif
		

func _on_gui_input(event):
	if event.is_action_pressed("LKM") and GB.focus_window == GB.BLOCK_SCHEMA:
		LKM_pressed = true
		old_mouse_position = get_local_mouse_position()
		
	if event.is_action_released("LKM"):
		LKM_pressed = false

func init_parent_child_blocks_dict():
	for begin_point:BeginPoint in $BeginPoints.get_children():
		child_blocks[begin_point.point_type] = null
	for end_point:EndPoint in $EndPoints.get_children():
		child_blocks[end_point.point_type] = null

	
