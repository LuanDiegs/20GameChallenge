extends VBoxContainer
class_name AlertsUI

@export var alert: Label = null

func _ready():
	# Connect the signals of the global class and set visible false by default
	visible = false
	AlertMediatorSingleton.connect("set_alert", set_alert)
	AlertMediatorSingleton.connect("exclude_alert", remove_alert)
	
	#Set the loop to never stop the tween
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.7)
	tween.tween_property(self, "scale", Vector2(1,1), 0.7)
	
	
func set_alert(alert_text: String):
	# Visible true and set the text in the alert
	visible = true
	alert.text = alert_text
	

func remove_alert():
	# Set visible false and remove the text in the alert
	visible = false
	alert.text = ""
