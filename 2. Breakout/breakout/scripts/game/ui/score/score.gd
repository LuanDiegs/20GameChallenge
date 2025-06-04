extends VBoxContainer
class_name ScoreUI

@onready var score = $MarginContainer/ScoreDivideContainer/Score
@onready var high_score = $MarginContainer/ScoreDivideContainer/HighScore


func _ready():
	# Initialize score
	ScoreSingleton.initialize_highscore()
	update_score()
	ScoreSingleton.connect("updated_score", update_score)
	

func update_score():
	score.text = str(ScoreSingleton.get_score())
	high_score.text = str(ScoreSingleton.get_highscore())
