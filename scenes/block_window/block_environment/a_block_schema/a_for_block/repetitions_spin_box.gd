extends SpinBox

@onready var repetition_amount_label: Label = %RepetitionAmountLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	repetition_amount_label.text = str(value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_value_changed(value: float) -> void:
	repetition_amount_label.text = str(value)
