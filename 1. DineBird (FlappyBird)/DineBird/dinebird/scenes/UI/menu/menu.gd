extends CanvasLayer
class_name Interface

@onready var _actual_score = $Panel/Container/ActualScoreContainer/ActualScore
@onready var _max_points = $Panel/Container/MaxPointsContainer/MaxPoints


func _ready():
	var score = Score
	score.connect("updated_score", update_score)

func update_score():
	var score = Score.get_score()
	var highscore = Score.get_highscore()
	_actual_score.text = str(score)
	_max_points.text = str(highscore)
