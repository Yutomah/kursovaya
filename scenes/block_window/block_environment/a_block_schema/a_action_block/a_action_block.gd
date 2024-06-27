extends ABlock
class_name AActionBlock

@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton
@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit

@onready var arrows: Arrows = %Arrows
@onready var pencil_mode: OptionButton = %PencilMode

@onready var direction_texture_rect: TextureRect = %DirectionTextureRect
@onready var type_texture_rect: TextureRect = %TypeTextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	spawn_block_button.item_pressed.connect(on_item_pressed)
	block_type = "Блок действия"
	
	direction_texture_rect.texture = load(arrows.get_arrow_path())
	type_texture_rect.texture = load(pencil_mode.get_pencil_path())
	arrows.arrow_selected.connect(func(): direction_texture_rect.texture = load(arrows.get_arrow_path()))
	pencil_mode.pencil_selected.connect(func(): type_texture_rect.texture = load(pencil_mode.get_pencil_path()))
	pass # Replace with function body.

func send_msg_to_log(zap:Zap):
	var arrow_path = arrows.get_arrow_path()
	var msg
	if pencil_mode.is_jumping():
		msg = "%s: курсор перемещён в сторону [img]%s[/img]" % [block_type, arrow_path]
	else:
		msg = "%s: линия нарисована в сторону [img]%s[/img]" % [block_type, arrow_path]
	zap.log_group.write_record(msg, self)

func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		
		var direction = arrows.get_direction()
		
		var line_drawed:bool
		if pencil_mode.is_jumping():
			line_drawed = zap.grid_line.line_jump(direction)
		else:
			line_drawed = zap.grid_line.line_draw(direction)
			
		if line_drawed:
			get_next_block().zap_processing(zap)
		else:
			error_line_beyond_borders(zap)

func get_next_block():
	return zone.get_next_block(self)
				
#region saving
func serialize():
	
	var dict = {
		"type":block_type,
		"direction" : arrows.selected,
		"pencil_mode" : pencil_mode.selected
	}
	return dict	
	
func deserialize(dict):
	arrows.selected = dict["direction"]
	pencil_mode.selected = dict["pencil_mode"]
	
	arrows.arrow_selected.emit()
	pencil_mode.pencil_selected.emit()
	

#endregion
	
#region Alignment
func delete_me():
	queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)

func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
#endregion
