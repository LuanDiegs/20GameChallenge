extends Node2D
class_name Game

@onready var background_area = $Background/BackgroundArea
@onready var timer_obstacle = $TimerObstacle

var characterNode: DineCharacter
var is_game_over: bool = false

func _ready():
	is_game_over = false
	characterNode = get_tree().get_first_node_in_group("Player") as DineCharacter
	characterNode.connect("characterDead", game_over)
	
	Score.restart_score()
	
	create_obstacle()
	

func create_obstacle():
	var positionXObstacle = background_area.size.x + 100
	var positionYObstacle = get_viewport_rect().size.y/2
	var newObstacle = Obstacle.new().create_new_obstacle(positionXObstacle, positionYObstacle)
	add_child(newObstacle)
	

func increase_dificulty():
	var score = Score.get_score()
	if(score%5 == 0 and timer_obstacle.wait_time > 1.5):
		timer_obstacle.wait_time -= 0.1
	

func game_over():
	var gameOverScreen = preload("res://scenes/UI/game_over/game_over.tscn").instantiate()
	is_game_over = true
	add_child(gameOverScreen)
	
	Save.save_game()


func _on_timer_obstacle_timeout():
	create_obstacle()
	increase_dificulty()
	
	
func _input(event):
	if event.is_action_pressed("restart") or (event.is_action_pressed("restart_mobile") and is_game_over):
		get_tree().reload_current_scene()
