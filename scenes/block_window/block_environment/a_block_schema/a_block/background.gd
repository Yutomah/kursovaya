extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	var img = Image.new()
	img.load(texture_normal.resource_path)
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(img)
	texture_click_mask = bitmap





func _on_pressed():
	print_debug(self)

