extends Node

signal state_changed()
signal activate_all_begin_blocks_wanted()

enum STATE {PLAY, PAUSE, STOP, CLEAR}
var previous_state
var state = STATE.CLEAR:
	set(value):
		previous_state = state
		state = value
		state_changed.emit()


enum INPUT {PLAY, LPLAY, PAUSE_CONTINUE, STOP, LSTOP, CLEAR}

func process_input(input: INPUT):
	match state:
		STATE.PLAY:
			play_state(input)
		STATE.PAUSE:
			pause_state(input)
		STATE.STOP:
			stop_state(input)
		STATE.CLEAR:
			clear_state(input)
		
			
func play_state(input:INPUT):
	match input:
		INPUT.PLAY:
			state = STATE.STOP
			process_input(input)
		INPUT.LPLAY:
			pass
		INPUT.PAUSE_CONTINUE:
			state = STATE.PAUSE
		INPUT.STOP:
			state = STATE.STOP
		INPUT.LSTOP:
			if get_tree().get_nodes_in_group("working_blocks").size() == 0:
				state = STATE.STOP
				process_input(INPUT.STOP)
		INPUT.CLEAR:
			state = STATE.STOP
			process_input(input)
	
func pause_state(input:INPUT):
	match input:
		INPUT.PLAY:
			state = STATE.STOP
			process_input(input)
		INPUT.LPLAY:
			pass
		INPUT.PAUSE_CONTINUE:
			state = STATE.PLAY
		INPUT.STOP:
			state = STATE.STOP
			pass
		INPUT.LSTOP:
			if get_tree().get_nodes_in_group("working_blocks").size() == 0:
				state = STATE.STOP
				process_input(INPUT.STOP)
		INPUT.CLEAR:
			state = STATE.STOP
			process_input(input)
	
func stop_state(input:INPUT):
	match input:
		INPUT.PLAY:
			state = STATE.CLEAR
			process_input(input)
		INPUT.LPLAY:
			state = STATE.CLEAR
			process_input(input)
		INPUT.PAUSE_CONTINUE:
			pass
		INPUT.STOP:
			pass
		INPUT.LSTOP:
			pass
		INPUT.CLEAR:
			state = STATE.CLEAR
			process_input(input)
	
func clear_state(input:INPUT):
	match input:
		INPUT.PLAY:
			state = STATE.PLAY
			activate_all_begin_blocks_wanted.emit()
		INPUT.LPLAY:
			state = STATE.PLAY
		INPUT.PAUSE_CONTINUE:
			pass
		INPUT.STOP:
			pass
		INPUT.LSTOP:
			pass
		INPUT.CLEAR:
			pass
