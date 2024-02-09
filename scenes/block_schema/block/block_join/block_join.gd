extends Block

@onready var end_point_scene = preload("res://scenes/block_schema/block/block_link/end_point.tscn")
@onready var begin_point_scene = preload("res://scenes/block_schema/block/block_link/begin_point.tscn")
@onready var DEFAULT_SIZE = size
@onready var DEFAULT_POS = position
const START_ID = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func zap_processing(zap:Zap):
	for begin_point in $BeginPoints.get_children():
		if begin_point.end_point != null:
			var next_block:Block = begin_point.end_point.get_parent().get_parent()
			var new_zap:Zap = zap.clone()
			next_block.zap_processing(new_zap)
		else:
			print("Отсутствует блок для последующей передачи")

func _on_accept_button_pressed():
	change_end_point_amount()
	change_begin_point_amount()
	relocate_points()
	
func change_end_point_amount():
	var point_amount:int = $VBoxContainer/EndPointAmountContainer/SpinBox.value
	var dif =  point_amount - $EndPoints.get_child_count()
	if dif > 0:
		for i in range(dif):
			var end_point:EndPoint = end_point_scene.instantiate()
			$EndPoints.add_child(end_point)
	elif dif < 0:
		var max_point_amount = $EndPoints.get_child_count()
		for i in range(-dif):
			var end_point = $EndPoints.get_child(max_point_amount - 1 - i)
			remove_end_point(end_point)
			

func change_begin_point_amount():
	var point_amount:int = $VBoxContainer/BeginPointAmountContainer/SpinBox.value
	var dif =  point_amount - $BeginPoints.get_child_count()
	if dif > 0:
		for i in range(dif):
			var begin_point:BeginPoint = begin_point_scene.instantiate()
			begin_point.position.y = size.y
			$BeginPoints.add_child(begin_point)
	elif dif < 0:
		var max_point_amount = $BeginPoints.get_child_count()
		for i in range(-dif):
			var begin_point = $BeginPoints.get_child(max_point_amount - 1 - i)
			remove_begin_point(begin_point)
			
func remove_end_point(end_point:EndPoint):
	if end_point.begin_point != null:
		end_point.begin_point.end_point = null
	end_point.free()

func remove_begin_point(begin_point:BeginPoint):
	if begin_point.end_point != null:
		begin_point.end_point.begin_point = null
	begin_point.free()
	
func relocate_points():
	var old_center_pos = Vector2(position.x+size.x/2, position.y+size.y/2)
	
	var biggest_points_amount
	var begin_points_amount = $BeginPoints.get_child_count()
	var end_points_amount = $EndPoints.get_child_count()
	if end_points_amount > begin_points_amount:
		biggest_points_amount = end_points_amount
	else:
		biggest_points_amount = begin_points_amount
	
	#определяемся с размерами и позицией блока
	size.x = DEFAULT_SIZE.x
	if biggest_points_amount > 5:
		size.x = 50 * (biggest_points_amount + 1)
	position = Vector2(old_center_pos.x - size.x/2, old_center_pos.y - size.y/2)
	
	#находим интервалы
	var begin_interval = size.x / (begin_points_amount + 1)
	var end_interval = size.x / (end_points_amount + 1)
	
	
	var count = 1
	for end_point:EndPoint in $EndPoints.get_children():
		end_point.position.x = end_interval * count
		count+=1
		
	count = 1
	for begin_point:BeginPoint in $BeginPoints.get_children():
		begin_point.position.x = begin_interval * count
		count+=1
