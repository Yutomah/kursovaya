extends TextureButton

@export var ablock:ABlock
@onready var popup_panel: PopupPanel = %PopupPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	var img = Image.new()
	img.load(texture_normal.resource_path)
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(img)
	texture_click_mask = bitmap



func _on_gui_input(event):
	if event.is_action_pressed("RKM"):
		popup_panel.visible = true
		popup_panel.position = get_viewport().get_mouse_position()
	if event.is_action_pressed("LKM"):
		pass
