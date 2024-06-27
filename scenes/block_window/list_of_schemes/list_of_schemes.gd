extends ScrollContainer

@onready var h_box_container: HBoxContainer = %HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GB.block_begin_array_changed.connect(update_options)

func update_options():
	for child in h_box_container.get_children():
		h_box_container.remove_child(child)
		
	for zone in GB.begin_zones:
		var schema_scene = load("res://scenes/block_window/list_of_schemes/schema.tscn")
		var schema = schema_scene.instantiate()
		schema.zone = zone
		h_box_container.add_child(schema)
