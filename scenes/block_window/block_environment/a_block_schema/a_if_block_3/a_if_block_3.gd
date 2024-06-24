extends ABlock
class_name AIfBlock3

@onready var left_spawn_button: SpawnBlockButton = %LeftSpawnButton
@onready var right_spawn_button: SpawnBlockButton = %RightSpawnButton


@onready var entrance: Marker2D = %Entrance
@onready var left_exit: Marker2D = %LeftExit
@onready var right_exit: Marker2D = %RightExit

@onready var distance_spin_box: SpinBox = %DistanceSpinBox
@onready var arrows: Arrows = %Arrows

@onready var direction_texture_rect: TextureRect = %DirectionTextureRect
@onready var distance_display_label: Label = %DistanceDisplayLabel

func _ready():
	left_spawn_button.item_pressed.connect(on_left_pressed)
	right_spawn_button.item_pressed.connect(on_right_pressed)
	block_type = "Блок если"
	block_type_label.text = block_type
	
	direction_texture_rect.texture = load(arrows.get_arrow_path())
	arrows.arrow_selected.connect(func(): direction_texture_rect.texture = load(arrows.get_arrow_path()))
	
	super._ready()

func get_left_next_block():
	return zone.get_left_next_block()
	
func get_right_next_block():
	return zone.get_right_next_block()
	
func send_msg_to_log(zap:Zap):
	var arrow_path = arrows.get_arrow_path()
	var direction = arrows.get_direction()
	var distance = distance_spin_box.value
	
	var result = !zap.grid_line.check_for_border(direction, distance)
	var msg = "%s: Произведена проверка на стену в сторону [img]%s[/img] на дистанции %s. Результат: %s." \
			% [block_type, arrow_path, distance, result]
	zap.log_group.write_record(msg, self)
	
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		
		var direction = arrows.get_direction()
		var distance = distance_spin_box.value
		
		if zap.grid_line.check_for_border(direction, distance):
			get_right_next_block().zap_processing(zap)
		else:
			get_left_next_block().zap_processing(zap)
	

#region saving
func serialize():
	var dict = {
		"type":block_type,
		"distance":distance_spin_box.value,
		"direction":arrows.selected
	}
	return dict	

func deserialize(dict):
	distance_spin_box.value = dict["distance"]
	arrows.selected = dict["direction"]
	
	arrows.arrow_selected.emit()
	distance_display_label.text = str(distance_spin_box.value)
#endregion

#region Alignment
func delete_me():
	zone.queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)

func on_left_pressed(ablock):
	zone.spawn_left(ablock)
	
func on_right_pressed(ablock):
	zone.spawn_right(ablock)
#endregion
