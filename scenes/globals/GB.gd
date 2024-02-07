extends Node

#drawing_field
signal clear_field_wanted
signal camera_to_default_wanted
signal change_field_size_wanted(is_infinite:bool, size:Vector2i)
signal change_drawing_window_vision

signal line_creation_wanted(block_begin:BlockBegin)
signal line_created(block_begin:BlockBegin, grid_line:GridLine)
signal line_draw_wanted(block_begin:BlockBegin, direction:Vector2i)
signal line_jump_wanted(block_begin:BlockBegin, direction:Vector2i)
signal line_draw_ended(result:bool)

#blocks
signal link_activated(begin_point:BeginPoint)
signal link_deactivated(last_mouse_pos:Vector2)

signal block_rkm_menu_opened()
signal block_schema_rkm_menu_opened()
signal activate_all_begin_blocks_wanted()


var is_block_rkm_menu_open:bool = false

enum {NONE_WINDOW, MAIN_WINDOW, DRAW_WINDOW, BLOCK_SCHEMA}
enum {NONE_TOOL, SELECTION_TOOL, HAND_TOOL, ZOOM_TOOL}

var focus_window = NONE_WINDOW
var current_tool = NONE_TOOL
