extends ScrollContainer
class_name LogGroup

var zap:Zap
var log_record_scene = preload("res://scenes/log_window/log_record/log_record.tscn")
var color:Color
func remove_myself():
	queue_free()

func write_record(msg:String, block:GBlock):
	var log_record:LogRecord = log_record_scene.instantiate()
	log_record.write_record(msg, block)
	$VBoxContainer.add_child(log_record)
