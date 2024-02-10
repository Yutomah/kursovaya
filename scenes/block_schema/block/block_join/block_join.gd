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
	if child_blocks[BeginPoint.PointType.COMMON_POINT] != null:
			child_blocks[BeginPoint.PointType.COMMON_POINT].zap_processing(zap)
	else:
		print("Отсутствует блок для последующей передачи")

func _on_accept_button_pressed():
	change_point_amount()
	relocate_points()
	refresh_links()
	
func change_point_amount():
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
			

			
func remove_end_point(end_point:EndPoint):
	if end_point.begin_point != null:
		end_point.begin_point.end_point = null
	end_point.free()
	
func relocate_points():
	var old_center_pos = Vector2(position.x+size.x/2, position.y+size.y/2)
	
	var points_amount = $EndPoints.get_child_count()
	
	#определяемся с размерами и позицией блока
	size.x = DEFAULT_SIZE.x
	if points_amount > 5:
		size.x = 50 * (points_amount + 1)
	position = Vector2(old_center_pos.x - size.x/2, old_center_pos.y - size.y/2)
	
	#находим интервалы
	var interval = size.x / (points_amount + 1)
	
	var count = 1
	for end_point:EndPoint in $EndPoints.get_children():
		end_point.position.x = interval * count
		count+=1

func refresh_links():
	for end_point in $EndPoints.get_children():
		if end_point.begin_point != null:
			end_point.begin_point.get_parent().get_parent().refresh_link()
