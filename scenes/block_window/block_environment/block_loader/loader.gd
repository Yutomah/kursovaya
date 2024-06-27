extends Node2D
class_name Loader
#
var save_folder = "user://saves"

func _ready():
	GB.loader = self

func get_all_saves():
	DirAccess.make_dir_absolute("user://saves")
	return DirAccess.get_files_at("user://saves")

func single_serialize(zone:ABeginZone):
	var dict = {}
	dict[zone] = zone.serialize()
	
	return JSON.stringify(dict, "   ")
	
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
	
	GB.id_map = {null:null}
	for key in blocks:
		var begin_zone_scene = load("res://scenes/block_window/block_environment/zones/a_begin_zone/a_begin_zone.tscn")
		var begin_zone = begin_zone_scene.instantiate()
		GB.spawn_begin_zone.emit(begin_zone)
		begin_zone.deserialize(blocks[key])
	GB.load_ended.emit()
	
