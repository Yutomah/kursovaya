extends SpinBox


@onready var distance_display_label: Label = %DistanceDisplayLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	distance_display_label.text = str(value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_value_changed(value: float) -> void:
	distance_display_label.text = str(value)
