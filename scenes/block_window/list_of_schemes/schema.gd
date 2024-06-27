extends PanelContainer

var zone
@onready var button: Button = %Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.text = zone.a_begin_block.block_name
	#get("theme_override_styles/panel").set("border_color", zone.a_begin_block.pencil_color)
	pass

func _on_button_pressed() -> void:
	GB.camera_to_zone_wanted.emit(zone)
