extends Label


func _ready():
	GB.block_amount_changed.connect(update_block_amount)
	call_deferred("update_block_amount")
	#call_
	#print("block ", GB.block_amount)
	#GB.block_amount_wanted.emit()

func update_block_amount():
	text = str(GB.block_amount)
