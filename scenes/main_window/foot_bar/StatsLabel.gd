extends Label


func _ready():
	GB.block_amount_changed.connect(func(x): text = str(x))
	GB.block_amount_wanted.emit()
