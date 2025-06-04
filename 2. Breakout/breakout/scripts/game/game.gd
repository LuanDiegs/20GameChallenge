extends Node2D
class_name Game


func _on_death_area_body_entered(body: Node2D) -> void:
	# If the body is a ball, it will be deleted
	if(body.is_in_group(GroupsSingleton.BallGroup)):
		body.queue_free()
	
		# See the quantity of balls in the game
		var balls_in_game = get_tree().get_nodes_in_group(GroupsSingleton.BallGroup).size()

		# If theres no ball in the game, the game ends
		if(balls_in_game <= 1):
			#TODO: GameOver screen
			SaveSystemSingleton.save_game()
			ScoreSingleton.reset_score()
			get_tree().call_deferred("reload_current_scene") 
