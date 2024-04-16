extends GBlock
class_name GBlockJoin

@onready var begin_point:GBeginPoint = $BeginPoints/GBeginPoint
@onready var end_point_scene:PackedScene = preload("res://scenes/block_window\
/block_environment/g_block_schema/g_block/gui_point_links/g_end_point.tscn")
@onready var begin_point_scene:PackedScene = preload("res://scenes/block_window\
/block_environment/g_block_schema/g_block/gui_point_links/g_begin_point.tscn")
@onready var DEFAULT_SIZE = $Control.size

func _ready():
	super._ready()

func _process(delta):
	super._process(delta)
	
func _on_accept_button_pressed():
	change_point_amount()
	relocate_points()
	refresh_links()

func change_point_amount():
	var point_amount:int = $Control/MarginContainer/Content/EndPointAmountContainer/SpinBox.value
	var dif =  point_amount - $EndPoints.get_child_count()
	if dif > 0:
		for i in range(dif):
			var end_point:GEndPoint = end_point_scene.instantiate()
			$EndPoints.add_child(end_point)
	elif dif < 0:
		var max_point_amount = $EndPoints.get_child_count()
		for i in range(-dif):
			var end_point = $EndPoints.get_child(max_point_amount - 1 - i)
			remove_end_point(end_point)

func remove_end_point(end_point:GEndPoint):
	end_point.remove_link()
	end_point.free()
	
func relocate_points():
	var points_amount = $EndPoints.get_child_count()
	
	#определяемся с размерами и позицией блока
	$Control.size.x = DEFAULT_SIZE.x
	if points_amount > 5:
		$Control.size.x = 50 * (points_amount + 1)
	var XOffset =  -$Control.size.x/2
	var YOffset =  -$Control.size.y/2
	$Control.position = Vector2(XOffset, YOffset)
	#находим интервалы
	var interval = $Control.size.x / (points_amount + 1)
	
	var count = 1
	
	for end_point:GEndPoint in $EndPoints.get_children():
		end_point.position.x =XOffset + interval * count
		end_point.position.y = YOffset
		count+=1

func refresh_links():
	for end_point:GEndPoint in $EndPoints.get_children():
		if end_point.begin_point != null:
			end_point.begin_point.update_static_line_pos()
			
func zap_processing(zap:Zap):
	if await zap_processing_control(zap):
		zap.log_group.write_record(block_name, self)
		if begin_point.end_point != null:
			begin_point.end_point.block.zap_processing(zap)
		else:
			error_next_block_not_exist(zap)
		
