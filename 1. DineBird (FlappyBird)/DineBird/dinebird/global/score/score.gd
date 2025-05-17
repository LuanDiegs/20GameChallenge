extends Node
class_name Scores

var score: int
var highscore: int

signal updated_score


func _ready():
	var highscore_saved = Save.load_save()
	if !highscore_saved.is_empty():
		highscore = highscore_saved.score


func restart_score():
	score = 0
	updated_score.emit()
	
	
func increment_score():
	score+=1
	if score > highscore:
		highscore = score
	updated_score.emit()


func get_score() -> int:
	return score


func get_highscore() -> int:
	return highscore
