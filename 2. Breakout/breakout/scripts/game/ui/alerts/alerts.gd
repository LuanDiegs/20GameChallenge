extends VBoxContainer
class_name AlertsUI

@export var alert: Label = null
@onready var alert_timer = $AlertTimer

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
	
	# Set the timer to remove the alert by default
	alert_timer.connect("timeout", remove_alert)
	
	
func set_alert(alert_text: String, wait_time: int):
	# Visible true and set the text in the alert
	visible = true
	alert.text = alert_text
	
	alert_timer.wait_time = wait_time
	alert_timer.start()
	

func remove_alert():
	# Set visible false and remove the text in the alert
	visible = false
	alert.text = ""
	alert_timer.stop()
