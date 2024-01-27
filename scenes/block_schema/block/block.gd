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
		
var child_block:Block = null:
	set(value):
		child_block = value
		if value != null:
			$VBoxContainer/Child.text = value.name
		else:
			$VBoxContainer/Child.text = "null"

# Called when the node enters the scene tree for the first time.
func _ready():
	GB.focus_window = GB.BLOCK_SCHEMA
	$VBoxContainer/Me.text = self.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if LKM_pressed:
		var dif = get_local_mouse_position() - old_mouse_position
		position += dif
		if $LinkBegin.end_node != null:
			$LinkBegin.get_node("Line2D").points[1] -= dif
		
		if $LinkEnd.begin_node != null:
			$LinkEnd.begin_node.get_node("Line2D").points[1] += dif

func _on_gui_input(event):
	if event.is_action_pressed("LKM") and GB.focus_window == GB.BLOCK_SCHEMA:
		
		LKM_pressed = true
		old_mouse_position = get_local_mouse_position()
	if event.is_action_released("LKM"):
		
		LKM_pressed = false
