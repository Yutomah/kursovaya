extends ABlock
class_name ABeginBlock

@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton
@onready var exit: Marker2D = %Exit

@onready var name_line_edit: LineEdit = %NameLineEdit
@onready var on_off_check_box: CheckBox = %OnOffCheckBox
@onready var color_picker_button: ColorPickerButton = %ColorPickerButton

@onready var color_rect: ColorRect = %ColorRect
@onready var name_label: Label = %NameLabel
@onready var on_off_label: Label = %OnOffLabel



var zap:Zap = null
var pencil_color:Color
var is_stepped:bool = false

var block_name:String = ""

func _ready():
	super._ready()
	spawn_block_button.item_pressed.connect(on_item_pressed)
	PSM.activate_all_begin_blocks_wanted.connect(on_activate_all)
	block_type = "Начальный блок"
	block_type_label.text = block_type
	GB.block_begin_array_changed.emit()
	pencil_color = color_picker_button.color
	pass # Replace with function body.

func on_activate_all():
	if !on_off_check_box.button_pressed:
		zap_processing()
		
func send_msg_to_log(zap:Zap):
	var msg = "%s: ветка запущена" % block_type
	zap.log_group.write_record(msg, self)
	
func zap_processing():
	
	if zap != null:
		zap.remove_myself()
	add_to_group("working_blocks")
	
	zap = Zap.new()
	zap.a_begin_block = self
	pencil_color = color_picker_button.color
	
	is_stepped = false
	GB.line_creation_wanted.emit(zap)
	GB.create_log_group_wanted.emit(zap)
	
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		get_next_block().zap_processing(zap)
		

func arg_zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		var msg = "%s: функция запущена" % block_type
		zap.log_group.write_record(msg, self)
		get_next_block().zap_processing(zap)

			
func get_next_block():
	return zone.get_next_block(self)
	
	
#region saving
func serialize():
	var dict = {
		"type":block_type,
		"color_r":pencil_color.r,
		"color_g":pencil_color.g,
		"color_b":pencil_color.b,
		"color_a":pencil_color.a,
		"on_off":on_off_check_box.button_pressed,
		"name":block_name,
		"self":self
	}
	return dict
	
func deserialize(dict):
	var p = Color(dict["color_r"], dict["color_g"], dict["color_b"], dict["color_a"])
	pencil_color = p
	color_picker_button._on_color_changed(pencil_color)
	
	on_off_check_box.button_pressed = dict["on_off"]
	
	block_name = dict["name"]
	name_line_edit._on_text_changed(block_name)
	
	GB.id_map[dict["self"]] = self
	
	
#endregion
#region Alignment
func delete_me():
	var my_zone = GB.get_my_begin_zone(self)
	GB.begin_zones.erase(my_zone)
	my_zone.queue_free()
	GB.block_begin_array_changed.emit()
	
func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
#endregion
