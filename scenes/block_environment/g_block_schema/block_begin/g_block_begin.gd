extends GBlock
class_name GBlockBegin

@export var begin_point:GBeginPoint  

# Called when the node enters the scene tree for the first time.
func _ready():
	class_type = "Начальный блок"
	super._ready()
	GB.activate_all_begin_blocks_wanted.connect(zap_processing)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func zap_processing():
	var zap = Zap.new()
	zap.block_begin = self
	GB.line_creation_wanted.emit(zap)
	if begin_point.end_point != null:
		begin_point.end_point.block.zap_processing(zap)
	else:
		print("Прерывание сигнала")


func _on_activate_button_pressed():
	zap_processing()
