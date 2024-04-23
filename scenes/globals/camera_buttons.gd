extends HBoxContainer

@export var camera_zooms:Array[float] = [1, 0.75, 0.5, 0.25]
var current_zoom = 0
enum WIN_TYPE{BLOCK_WINDOW, DRAW_WINDOW, LOG_WINDOW}
@export var window_type:WIN_TYPE
func _ready():
	$ZoomIn.disabled = true

func _on_zoom_out_pressed():
	current_zoom += 1
	$ZoomIn.disabled = false
	GB.camera_zoom_to.emit(camera_zooms[current_zoom], window_type)
	if current_zoom == camera_zooms.size()-1:
		$ZoomOut.disabled = true


func _on_return_pressed():
	GB.camera_to_default_wanted.emit(window_type)
	current_zoom = 0
	$ZoomIn.disabled = true
	$ZoomOut.disabled = false


func _on_zoom_in_pressed():
	current_zoom -= 1
	$ZoomOut.disabled = false
	GB.camera_zoom_to.emit(camera_zooms[current_zoom], window_type)
	if current_zoom == 0:
		$ZoomIn.disabled = true
		

