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

#blocks
signal hand_tool_on_block_pressed(event:InputEvent)
signal block_name_changed()
signal block_begin_array_changed(begin_block_array:Array[GBlockBegin])

#context_menu
signal context_menu_open_wanted(context_menu:ContextMenu)


#tools
enum {NONE_TOOL, SELECTION_TOOL, HAND_TOOL, ZOOM_TOOL}
var current_tool = SELECTION_TOOL

# zap_player
signal activate_all_begin_blocks_wanted()
signal continue_all_blocks_wanted()
signal stop_all_blocks_wanted()
var running:bool = false
var paused:bool = false
