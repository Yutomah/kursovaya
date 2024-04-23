extends Node2D
class_name GBeginPoint

var LKM_pressed = false

@onready var line:Line2D = %Line
@onready var block:GBlock = get_parent().get_parent()
var end_point:GEndPoint
@export var point_label:String

func _ready():
	$Label.text = point_label
	
func _draw():
	draw_circle(Vector2.ZERO, 7, Color.SKY_BLUE)

func _process(_delta):
	if LKM_pressed:
		line.points[1] = get_local_mouse_position()

func _on_gui_input(event):
	if event.is_action_pressed("LKM") and GB.current_tool == GB.SELECTION_TOOL:
		LKM_pressed = true
		$ControlBegin.accept_event()

func _input(event):
	if event.is_action_released("LKM") and LKM_pressed:
		LKM_pressed = false
		remove_link()
		var focus_owner = get_viewport().gui_get_focus_owner()
		if focus_owner != null and focus_owner.get_parent() is GEndPoint:
			create_link(focus_owner.get_parent())

func remove_link():
	if end_point != null:
		end_point.begin_point = null
		end_point = null
	update_static_line_pos()
		

func create_link(end_point:GEndPoint):
	end_point.remove_link()
	end_point.begin_point = self
	self.end_point = end_point
	update_static_line_pos()

func update_static_line_pos():
	if end_point != null:
		line.points[-1] = line.to_local(end_point.to_global(Vector2.ZERO))
	else:
		line.points[-1] = Vector2.ZERO
