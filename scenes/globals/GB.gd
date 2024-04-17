extends Node

#drawing_field
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

#log
signal create_log_group_wanted(zap:Zap)

#context_menu
signal context_menu_open_wanted(context_menu:ContextMenu)

signal loader_created(loader:Loader)

#tools
enum {NONE_TOOL, SELECTION_TOOL, HAND_TOOL, ZOOM_TOOL}
var current_tool = SELECTION_TOOL
