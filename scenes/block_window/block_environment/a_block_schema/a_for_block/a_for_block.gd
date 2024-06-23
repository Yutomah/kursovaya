extends ABlock
class_name AForBlock

@onready var spawn_block_button: SpawnBlockButton = %SpawnBlockButton

@onready var entrance: Marker2D = %Entrance
@onready var exit: Marker2D = %Exit

@onready var cycle_entrance: Marker2D = %CycleEntrance
@onready var cycle_exit: Marker2D = %CycleExit

@onready var repetitions_spin_box: SpinBox = %RepetitionsSpinBox

func _ready():
	super._ready()
	spawn_block_button.item_pressed.connect(on_item_pressed)
	block_type = "Блок for"
	pass 

func get_next_block():	
	return zone.get_next_block(self)
	
func get_next_block_exit():
	return zone.get_next_block_exit(self)

func send_msg_to_log(zap:Zap):
	var max_count = repetitions_spin_box.value
	var current_count = zap.for_counters[str(self)]
	var result = zap.for_counters[str(self)] < repetitions_spin_box.value
	
	var msg
	if result:
		msg = "%s: значение счётчика = %s, нужно считать до %s, цикл продолжается" % [block_type, current_count, max_count]
	else:
		msg = "%s: значение счётчика = %s, нужно считать до %s, цикл завершён" % [block_type, current_count, max_count]
	zap.log_group.write_record(msg, self)
	
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		
		if !zap.for_counters.has(str(self)):
			zap.for_counters[str(self)] = 0
			
		send_msg_to_log(zap)
		if zap.for_counters[str(self)] < repetitions_spin_box.value:
			zap.for_counters[str(self)] += 1
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
