extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_toggled(toggled_on):
	$"../WidthContainer/WidthLineEdit".editable = not toggled_on
	$"../HeightContainer/HeightLineEdit".editable = not toggled_on
