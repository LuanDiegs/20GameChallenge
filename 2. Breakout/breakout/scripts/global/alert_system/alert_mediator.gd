extends Node
class_name AlertMediator

signal set_alert(alert)
signal exclude_alert


func create_alert(alert_text: String, wait_time: int = 3):
	set_alert.emit(alert_text, wait_time)


func remove_alert():
	exclude_alert.emit()
