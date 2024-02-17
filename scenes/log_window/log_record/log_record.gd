extends PanelContainer
class_name LogRecord

var block:GBlock

func write_record(msg:String, block:GBlock):
	self.block = block
	$Label.text = msg
	block.related_log_records.append(self)


func _on_gui_input(event):
	if event.is_action_pressed("LKM"):
		grab_focus()
		m_highlight()
		block.m_highlight()

func m_highlight():
	modulate = Color.BURLYWOOD

func m_dehighlight():
	modulate = Color.WHITE

func _on_focus_exited():
	m_dehighlight()
	block.m_dehighlight()
