extends Node

enum GAME_STATES { INITIAL, PAUSED, FINISHED, STARTED}
var current_state: GAME_STATES = GAME_STATES.INITIAL

signal end_game
signal paused_game
signal start_game
signal initial_state


func set_game_state(state: GAME_STATES):
	current_state = state
	
	match state:
		GAME_STATES.PAUSED:
			paused_game.emit()
		GAME_STATES.FINISHED:
			end_game.emit()
		GAME_STATES.STARTED:
			start_game.emit()
		GAME_STATES.INITIAL:
			initial_state.emit()
