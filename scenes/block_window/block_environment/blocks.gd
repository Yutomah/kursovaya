extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GB.spawn_begin_zone.connect(on_spawn_begin_zone)

func on_spawn_begin_zone(begin_zone):
	add_child(begin_zone)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
