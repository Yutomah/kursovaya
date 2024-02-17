extends PanelContainer
class_name LogRecord

var block:GBlock

func write_record(msg:String, block:GBlock):
	self.block = block
	$Label.text = msg
