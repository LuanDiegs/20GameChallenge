extends Button
class_name PauseButton


func _pressed() -> void:
	if GameState.current_state == GameState.GAME_STATES.STARTED:
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED	
		GameState.set_game_state(GameState.GAME_STATES.PAUSED)	
		get_tree().set_pause(true)
		
	elif GameState.current_state == GameState.GAME_STATES.PAUSED:
		get_tree().set_pause(false)		
		GameState.set_game_state(GameState.GAME_STATES.STARTED)
		process_mode = Node.PROCESS_MODE_INHERIT
