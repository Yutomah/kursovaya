extends ABlock
class_name AWhileBlock


@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton

@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit

@onready var cycle_entrance: Marker2D = %CycleEntrance
@onready var cycle_exit: Marker2D = %CycleExit

@onready var arrows: Arrows = %Arrows
@onready var distance_spin_box: SpinBox = %DistanceSpinBox


func _ready():
	super._ready()
	block_type = "Блок while"
	block_type_label.text = block_type
	spawn_block_button.item_pressed.connect(on_item_pressed)
	pass 


func get_next_block():	
	return zone.get_next_block(self)
	
func get_next_block_exit():
	return zone.get_next_block_exit(self)
	
func send_msg_to_log(zap:Zap):
	var arrow_path = arrows.get_arrow_path()
	
	var direction = arrows.get_direction()
	var distance = distance_spin_box.value
	
	var result = !zap.grid_line.check_for_border(direction, distance)
	var msg
	if result:
		msg = "%s: Произведена проверка на стену в сторону [img]%s[/img] на дистанции %s. Результат: %s. Цикл завершён." \
			% [block_type, arrow_path, distance, result]
	else:
		msg = "%s: Произведена проверка на стену в сторону [img]%s[/img] на дистанции %s. Результат: %s. Цикл продолжается." \
			% [block_type, arrow_path, distance, result]
	zap.log_group.write_record(msg, self)


func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		send_msg_to_log(zap)
		var direction = arrows.get_direction()
		var distance = distance_spin_box.value
		
		
		if zap.grid_line.check_for_border(direction, distance):
			get_next_block().zap_processing(zap)
		else:
			get_next_block_exit().zap_processing(zap)
	
#region Alignment
func delete_me():
	zone.queue_free()
	get_tree().create_timer(0.01).timeout.connect(GB.get_my_begin_zone(self).update_everything)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_item_pressed(ablock):
	zone.spawn_block(ablock, get_index()+1)
#endregion
