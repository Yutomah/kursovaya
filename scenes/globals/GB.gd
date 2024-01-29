extends Node

signal clear_field_wanted
signal camera_to_default_wanted
signal change_field_size_wanted(is_infinite:bool, size:Vector2i)
signal change_drawing_window_vision

signal link_activated(begin_point:BeginPoint)
signal link_deactivated(last_mouse_pos:Vector2)

enum {NONE_WINDOW, MAIN_WINDOW, DRAW_WINDOW, BLOCK_SCHEMA}
enum {NONE_TOOL, SELECTION_TOOL, HAND_TOOL, ZOOM_TOOL}

var focus_window = NONE_WINDOW
var current_tool = NONE_TOOL
