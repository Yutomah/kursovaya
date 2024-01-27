extends Node

signal clear_field_wanted
signal camera_to_default_wanted
signal change_field_size_wanted(is_infinite:bool, size:Vector2i)
signal change_drawing_window_vision
signal link_activated(begin_node:Area2D)
signal link_received(begin_node:Area2D, end_node:Area2D)
signal link_deactivated()

enum {MAIN_WINDOW, DRAW_WINDOW}
var focus_window = MAIN_WINDOW
