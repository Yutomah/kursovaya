extends TextureButton

@export var ablock:ABlock
@onready var popup_panel: PopupPanel = %PopupPanel

var dragging = false
var old_mouse_position:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	var img = Image.new()
	img.load(texture_normal.resource_path)
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(img)
	texture_click_mask = bitmap

func _process(_delta):
	if dragging:
		var dif = get_local_mouse_position() - old_mouse_position
		GB.get_my_begin_zone(self).position += dif
		
func _input(event: InputEvent) -> void:
	if event.is_action_released("LKM"):
		dragging = false
		
func _on_gui_input(event):
	if event.is_action_pressed("RKM"):
		popup_panel.visible = true
		popup_panel.position = get_viewport().get_mouse_position()
		
	if event.is_action_pressed("LKM") and GB.current_tool == GB.HAND_TOOL:
		GB.hand_tool_on_block_pressed.emit(event)
		
	if event.is_action_pressed("LKM") and GB.current_tool == GB.SELECTION_TOOL:
		if !dragging:
			dragging = true
			old_mouse_position = get_local_mouse_position()
	
	
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		ablock.a_highlight()
		ablock.m_highlight_related_log_records()
	


func _on_focus_exited() -> void:
	ablock.a_dehighlight()
	ablock.m_dehighlight_related_log_records()
