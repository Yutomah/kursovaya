extends Node2D
class_name Loader
#
var save_folder = "user://saves"
#@onready var BlockTypes = {
	#"begin" :preload("res://scenes/block_window/block_environment/g_block_schema/block_begin/g_block_begin.tscn"),
	#"action":preload("res://scenes/block_window/block_environment/g_block_schema/block_action/g_block_action.tscn"),
	#"if": preload("res://scenes/block_window/block_environment/g_block_schema/block_if/g_block_if.tscn"),
	#"end_if" : preload("res://scenes/block_window/block_environment/g_block_schema/block_end_if/g_block_end_if.tscn"),
	#"while":preload("res://scenes/block_window/block_environment/g_block_schema/block_while/g_block_while.tscn"),
	#"for":preload("res://scenes/block_window/block_environment/g_block_schema/block_for/g_block_for.tscn"),
	#"end" :preload("res://scenes/block_window/block_environment/g_block_schema/block_end/g_block_end.tscn"),
	#"func" :preload("res://scenes/block_window/block_environment/g_block_schema/block_function/g_block_function.tscn")
#}


func _ready():
	GB.loader_created.emit(self)
	#print(get_all_saves())
	#print(serialize())
	#save_blocks(serialize(), "my1")
	#load_blocks("my1")
	
func get_all_saves():
	DirAccess.make_dir_absolute("user://saves")
	return DirAccess.get_files_at("user://saves")

func serialize():
	var blocks = GB.begin_zones
	var dict = {}
	for block in blocks:
		dict[block] = block.serialize()
	return JSON.stringify(dict, "   ")
	
func remove_blocks(file_name):
	DirAccess.remove_absolute(save_folder.path_join(file_name))
	
func save_blocks(json_string, file_name):
	
	DirAccess.make_dir_absolute(save_folder)
	var file = FileAccess.open(save_folder.path_join(file_name), FileAccess.WRITE)
	file.store_string(json_string)
	
func load_blocks(file_name):
	var file = FileAccess.open(save_folder.path_join(file_name), FileAccess.READ)
	var content = file.get_as_text()
	
	
	var json = JSON.new()
	json.parse(content)
	var blocks = json.data
	
	for key in blocks:
		var begin_zone_scene = load("res://scenes/block_window/block_environment/zones/a_begin_zone/a_begin_zone.tscn")
		var begin_zone = begin_zone_scene.instantiate()
		GB.spawn_begin_zone.emit(begin_zone)
		begin_zone.deserialize(blocks[key])
		
	#var id_map = {null:null}
	#var new_blocks = []
	#for key in blocks:
		#var new_block = get_block_by_type(blocks[key]["type"])
		#new_blocks.append([blocks[key], new_block])
		#%GBlockSchema.add_child(new_block)
		#new_block.map_point_id(id_map, blocks[key])
		#pass
		#
	#for i in range(new_blocks.size()):
		#var new_block = new_blocks[i][1]
		#var old_block = new_blocks[i][0]
		#new_block.deserialize(old_block, id_map)
		#
	#for block in %GBlockSchema.get_children():
		#for begin_point in block.get_node("BeginPoints").get_children():
			#begin_point.update_static_line_pos()
	#
#func get_block_by_type(block_type):
	#match(block_type):
		#"Блок функции":
			#return BlockTypes["func"].instantiate()
		#"Блок действия":
			#return BlockTypes["action"].instantiate()
		#"Конечный блок":
			#return BlockTypes["end"].instantiate()
		#"Начальный блок":
			#return BlockTypes["begin"].instantiate()
		#"Блок for":
			#return BlockTypes["for"].instantiate()
		#"Блок while":
			#return BlockTypes["while"].instantiate()
		#"Блок если":
			#return BlockTypes["if"].instantiate()
		#"Конец если":
			#return BlockTypes["end_if"].instantiate()
		#
	#return -1
	#
