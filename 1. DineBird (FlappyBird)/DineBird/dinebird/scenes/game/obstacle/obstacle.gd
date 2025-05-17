extends Node2D
class_name Obstacle

const VELOCITY = 300

const MIN_SEPARATION_VALUE = 150
const MAX_SEPARATION_VALUE = 300

const MIN_SEPARATION_UPDOWN_VALUE = -100
const MAX_SEPARATION_UPDOWN_VALUE = 200

@onready var pipe_up = $PipeUp
@onready var pipe_down = $PipeDown


func _ready():
	configure_new_obstacle()
	
	
func _process(delta):
	position.x -= VELOCITY * delta
	
	if position.x < -100:
		queue_free()


func create_new_obstacle(positionXObstacle: float, positionYObstacle: float) -> Obstacle:
	var newObstacle = preload("res://scenes/game/obstacle/obstacle.tscn").instantiate()
	newObstacle.global_position = Vector2(positionXObstacle, positionYObstacle)
	
	return newObstacle
 

func configure_new_obstacle():
	var separationValue = randf_range(MIN_SEPARATION_VALUE, MAX_SEPARATION_VALUE)
	var separationIndividually = separationValue/2
	pipe_up.position.y -= separationIndividually
	pipe_down.position.y += separationIndividually
	
	var upDownSeparationValue = randf_range(MIN_SEPARATION_UPDOWN_VALUE, MAX_SEPARATION_UPDOWN_VALUE)
	position.y += upDownSeparationValue
