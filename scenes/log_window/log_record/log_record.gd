extends PanelContainer
class_name LogRecord

var block:ABlock

func write_record(msg:String, block:ABlock):
	self.block = block
	$Label.text = msg
	block.related_log_records.append(self)


func _on_gui_input(event):
	if event.is_action_pressed("LKM"):
		grab_focus()
		m_highlight()
		block.a_highlight()

func m_highlight():
	$ColorRect.self_modulate = Color.AQUAMARINE

func m_dehighlight():
	$ColorRect.self_modulate = Color.WHITE

func _on_focus_exited():
	m_dehighlight()
	block.a_dehighlight()
