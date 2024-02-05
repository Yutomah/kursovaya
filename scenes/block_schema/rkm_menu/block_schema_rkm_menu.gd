extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GB.block_rkm_menu_opened.connect(on_block_rkm_menu_opened)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	
	if event.is_action_pressed("RKM") and GB.focus_window == GB.MAIN_WINDOW \
	and GB.current_tool == GB.SELECTION_TOOL and !GB.is_block_rkm_menu_open:
		position = get_parent().get_local_mouse_position()
		show()
		GB.block_schema_rkm_menu_opened.emit()
	if event.is_action_pressed("LKM"):
		hide()

func on_block_rkm_menu_opened():
	hide()
	print(1)
