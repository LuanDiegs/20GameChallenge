extends Node
class_name AlertMediator

signal set_alert(alert)
signal exclude_alert


func create_alert(alert_text: String):
	set_alert.emit(alert_text)


func remove_alert():
	exclude_alert.emit()
