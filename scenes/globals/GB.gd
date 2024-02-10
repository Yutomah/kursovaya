extends Node

#drawing_field
signal clear_field_wanted
signal camera_to_default_wanted
signal change_field_size_wanted(is_infinite:bool, size:Vector2i)
signal change_drawing_window_vision

signal line_creation_wanted(zap:Zap)
signal line_draw_wanted(zap:Zap, direction:Vector2i)
signal line_jump_wanted(zap:Zap, direction:Vector2i)
signal line_draw_ended(result:bool)


signal block_rkm_menu_opened()
signal block_schema_rkm_menu_opened()
signal activate_all_begin_blocks_wanted()


var is_block_rkm_menu_open:bool = false

enum {NONE_TOOL, SELECTION_TOOL, HAND_TOOL, ZOOM_TOOL}

var current_tool = NONE_TOOL
