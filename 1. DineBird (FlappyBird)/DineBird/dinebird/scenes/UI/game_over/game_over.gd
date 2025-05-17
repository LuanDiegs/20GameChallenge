extends CanvasLayer
class_name GameOverScreen

@onready var points_label = $PanelContainer/CenterContainer/Container/Score/Points

func _ready():
	var score = Score.get_score()
	points_label.text = str(score)
