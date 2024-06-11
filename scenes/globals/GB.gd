extends Node2D

#drawing_field
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
signal block_amount_changed(block_amount:int)
signal block_amount_wanted()

#log
signal create_log_group_wanted(zap:Zap)

#context_menu
signal context_menu_open_wanted(context_menu:ContextMenu)

signal loader_created(loader:Loader)

#step by step
signal make_step()
var is_step_by_step:bool = false

#camera
signal camera_to_default_wanted(window_type)
signal camera_zoom_to(zoom_value:float, window_type)

#begin block
var used_colors:Dictionary = {}


#tools
enum {NONE_TOOL, SELECTION_TOOL, HAND_TOOL, ZOOM_TOOL}
var current_tool = SELECTION_TOOL

# window types
enum WIN_TYPE{BLOCK_WINDOW, DRAW_WINDOW, LOG_WINDOW}

var ablocks:Array[Dictionary] = [
	{"name" : "Блок действия", 
	"scene" : preload("res://scenes/block_window/block_environment/a_block_schema/a_action_block/a_action_block.tscn")},
	{"name" : "Блок если", 
	"scene" : preload("res://scenes/block_window/block_environment/zones/a_if_zone/a_if_zone.tscn")},
]

var h_separation = 50
var v_separation = 50
var default_min_size = Vector2(300,200)
