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
signal block_begin_array_changed()
signal block_amount_changed()
#signal block_amount_wanted()

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

var begin_zone_scene:PackedScene = preload("res://scenes/block_window/block_environment/zones/a_begin_zone/a_begin_zone.tscn")

var ablocks:Array[Dictionary] = [
	{"name" : "Блок действия", 
	"scene" : preload("res://scenes/block_window/block_environment/a_block_schema/a_action_block/a_action_block.tscn")},
	{"name" : "Блок если", 
	"scene" : preload("res://scenes/block_window/block_environment/zones/a_if_3/a_if_3.tscn")},
	{"name" : "Блок for", 
	"scene" : load("res://scenes/block_window/block_environment/zones/a_for_zone/a_for_zone.tscn")},
	{"name" : "Блок while", 
	"scene" : load("res://scenes/block_window/block_environment/zones/a_while_zone/a_while_zone.tscn")},
	{"name" : "Блок функции", 
	"scene" : load("res://scenes/block_window/block_environment/a_block_schema/a_function_block/a_function_block.tscn")},
]


var h_separation = 50
var v_separation = 50
var left_right_margin = 20

var default_min_size = Vector2(300,200)

var line_width:int = 3
var line_color:Color = Color.RED

var block_amount = 0


var begin_zones:Array[ABeginZone] = []
func get_my_begin_zone(block):
	if block is ABeginZone:
		return block
		
	for begin_zone in begin_zones:
		if begin_zone.is_ancestor_of(block):
			return begin_zone

signal spawn_begin_zone(begin_zone)
