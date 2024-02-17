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
