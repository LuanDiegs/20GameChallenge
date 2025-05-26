extends Node2D
class_name Game

@onready var _death_area: Area2D = $Limits/DeathArea


func _on_death_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group(GroupsSingleton.BallGroup)):
		#TODO: GameOver screen
		get_tree().call_deferred("reload_current_scene") 
