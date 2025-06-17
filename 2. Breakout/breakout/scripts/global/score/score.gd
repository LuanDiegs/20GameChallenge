extends Node

signal updated_score

var _score: int = 0
var _highScore: int = 0
var _score_multiplier: int = 1


func increment_score(points_to_add):
	_score += points_to_add * _score_multiplier
	
	if _score > _highScore:
		_highScore = _score
		
	updated_score.emit()


func change_multiplier(multiplier):
	_score_multiplier = multiplier


func get_score() -> int:
	return _score


func reset_score():
	_score = 0
	_score_multiplier = 1
	
	
func get_highscore() -> int:
	return _highScore


func initialize_highscore():
	var highscore_saved = SaveSystemSingleton.load_save()
	
	if highscore_saved.is_empty():
		return
		
	_highScore = highscore_saved.highScore
