extends Node2D
class_name Game

var started: bool = false

func _ready() -> void:
	GameState.set_game_state(GameState.GAME_STATES.INITIAL)
		

func _on_death_area_body_entered(body: Node2D) -> void:
	# If the body is a ball, it will be deleted
	if(body.is_in_group(GroupsSingleton.BallGroup)):
		body.queue_free()
	
		# See the quantity of balls in the game
		var balls_in_game = get_tree().get_nodes_in_group(GroupsSingleton.BallGroup).size()

		# If theres no ball in the game, the game ends
		if(balls_in_game > 1):
			return
		
		# The game is ended
		GameState.set_game_state(GameState.GAME_STATES.FINISHED)
		
		SaveSystemSingleton.save_game()
		ScoreSingleton.reset_score()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") && GameState.current_state == GameState.GAME_STATES.STARTED:
		GameState.set_game_state(GameState.GAME_STATES.PAUSED)
		get_tree().set_pause(true)	
