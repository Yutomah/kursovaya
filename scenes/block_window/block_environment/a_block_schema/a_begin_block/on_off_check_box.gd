extends CheckBox

@onready var on_off_label: Label = %OnOffLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if button_pressed:
		on_off_label.text = "(выкл)"
	else:
		on_off_label.text = "(вкл)"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		on_off_label.text = "(выкл)"
	else:
		on_off_label.text = "(вкл)"
