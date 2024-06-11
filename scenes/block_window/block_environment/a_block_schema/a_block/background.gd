extends TextureButton

@export var popup:Popup
# Called when the node enters the scene tree for the first time.
func _ready():
	var img = Image.new()
	img.load(texture_normal.resource_path)
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(img)
	texture_click_mask = bitmap



func _on_gui_input(event):
	if event.is_action_pressed("RKM"):
		popup.visible = true
		popup.position = get_viewport().get_mouse_position()
	if event.is_action_pressed("LKM"):
		print("lkm")
