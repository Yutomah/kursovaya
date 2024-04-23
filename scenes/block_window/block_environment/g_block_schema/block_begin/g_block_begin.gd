extends GBlock
class_name GBlockBegin

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint
var zap:Zap = null
# Called when the node enters the scene tree for the first time.

@export var colors:Array[Color]
var pencil_color:Color 
var is_stepped = false

func _ready():
	super._ready()
	PSM.activate_all_begin_blocks_wanted.connect(on_activate_all)
	pick_unique_color()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func pick_unique_color():
	var found = false
	for color in colors:
		if GB.used_colors.find_key(color) == null:
			GB.used_colors[str(self)] = color
			pencil_color = color
			$Control/ColorRect.color = color
			found = true
			break
	if !found:
		var c =  colors.pick_random()
		GB.used_colors[str(self)] = c
		pencil_color = c
		$Control/ColorRect.color = c

func send_msg_to_log(zap:Zap):
	var msg = "%s: ветка запущена" % block_name
	zap.log_group.write_record(msg, self)
	
func zap_processing():
	
	if zap != null:
		zap.remove_myself()
	add_to_group("working_blocks")
	
	zap = Zap.new()
	zap.block_begin = self
	is_stepped = false
	GB.line_creation_wanted.emit(zap)
	GB.create_log_group_wanted.emit(zap)
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		if begin_point.end_point != null:
			begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist(zap)

func arg_zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		var msg = "%s: функция запущена" % block_name
		zap.log_group.write_record(msg, self)
		if begin_point.end_point != null:
			begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist(zap)
	

func on_activate_all():
	if !$Control/MarginContainer/Content/MassActivationCheckbox.button_pressed:
		zap_processing()

func  serialize():
	
	var dict = super.serialize()
	dict["mass_activation"] = $Control/MarginContainer/Content/MassActivationCheckbox.button_pressed
	dict["begin_point"] = begin_point
	dict["link"] = begin_point.end_point
	return dict
	
func deserialize(dict, id_map):
	super.deserialize(dict, id_map)
	$Control/MarginContainer/Content/MassActivationCheckbox.button_pressed = dict["mass_activation"] 
	if id_map[dict["link"]] != null:
		begin_point.create_link(id_map[dict["link"]])
	

func map_point_id(id_map, dict):
	super.map_point_id(id_map, dict)
	id_map[dict["begin_point"]] = begin_point
