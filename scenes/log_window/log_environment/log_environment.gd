extends ScrollContainer
class_name LogEnvironment

var log_group_scene = preload("res://scenes/log_window/log_group/log_group.tscn")
func _ready():
	GB.create_log_group_wanted.connect(on_create_log_group_wanted)
	PSM.state_changed.connect(on_state_changed)
	
func on_create_log_group_wanted(zap:Zap):
	var log_group:LogGroup = log_group_scene.instantiate()
	zap.log_group = log_group
	log_group.zap = zap
	
	
	#var new_theme:Theme = Theme.new()
	#new_theme.add_type("ScrollContainer")
	#new_theme.set_color()
	#var styleBox: StyleBoxFlat = get_theme_stylebox("ScrollContainer")
	#styleBox.set("border_color", zap.block_begin.pencil_color)
	#styleBox.set("border_width_right", 3)
	#log_group.add_theme_stylebox_override("ScrollContainer", styleBox)
	#log_group.theme.set_color("border_color", "ScrollContainer", Color.RED)
	#log_group.add_color_override("border_color",Color.RED)
	#log_group.set("border_color", Color.RED)
	#print(log_group.get("theme_override_styles/panel"))
	log_group.get("theme_override_styles/panel").set("border_color", zap.block_begin.pencil_color)
	$HBoxContainer.add_child(log_group)
	
func clear_log_groups():
	for log_group:LogGroup in $HBoxContainer.get_children():
		log_group.remove_myself()

func on_state_changed():
	match PSM.state:
		PSM.STATE.PLAY:
			pass
		PSM.STATE.PAUSE:
			pass
		PSM.STATE.STOP:
			pass
		PSM.STATE.CLEAR:
			clear_log_groups()
