extends PopupMenu

@export var blocks:Node2D



func _on_id_pressed(id):
	match(id):
		0:
			var begin_zone = GB.begin_zone_scene.instantiate()
			begin_zone.global_position = blocks.get_global_mouse_position()
			blocks.add_child(begin_zone)
 
