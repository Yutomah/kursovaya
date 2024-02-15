extends GBlock
class_name GBlockEnd

@onready var end_point:GEndPoint = $EndPoints/GEndPoint

func _ready():
	super._ready()
	pass # Replace with function body.


func _process(delta):
	super._process(delta)
	pass

func zap_processing(zap:Zap):
	if await zap_processing_control():
		print("over")
	pass
