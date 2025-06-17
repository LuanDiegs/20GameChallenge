extends Button
class_name PauseButton


func _ready() -> void:
	# Set the process mode depending on the signal
	GameState.paused_game.connect(func(): process_mode = Node.PROCESS_MODE_WHEN_PAUSED)
	GameState.start_game.connect(func(): process_mode = Node.PROCESS_MODE_INHERIT)


func _pressed() -> void:
	print("apertou", GameState.current_state)
	if GameState.current_state == GameState.GAME_STATES.STARTED:
		get_tree().set_pause(true)
		GameState.set_game_state(GameState.GAME_STATES.PAUSED)	
		
	elif GameState.current_state == GameState.GAME_STATES.PAUSED:
		get_tree().set_pause(false)		
		GameState.set_game_state(GameState.GAME_STATES.STARTED)
