extends State
class_name RotateState

@export var POWERUP_STATE: PowerUpsStateMediator
@export var POWERUP_DURATION := 5.0

@onready var rotate_timer = $RotateTimer


func _ready():
	rotate_timer.wait_time = POWERUP_DURATION
	rotate_timer.connect("timeout", timeout_powerup)
	
	
func enter():
	# First whe start the timer, set the multiplier to 2x and set the alert of double points
	rotate_timer.start()
	ScoreSingleton.change_multiplier(2)
	AlertMediatorSingleton.create_alert("Double points!")
	
	# The rotation will stack, so if the player get a lot of rotate power-ups, when the rotation changes to 0 wlll be VERY fast hehe
	# The player will get double points but theres a price...
	var tween = create_tween()
	var paddle = POWERUP_STATE.paddle
	var rotation := deg_to_rad(rad_to_deg(paddle.rotation) + (180 * POWERUP_DURATION/2))
	tween.tween_property(paddle, "rotation", rotation, POWERUP_DURATION/2)	
	tween.tween_property(paddle, "rotation", deg_to_rad(0), POWERUP_DURATION/2)	


func update():
	pass


func timeout_powerup():
	# Stop the timer, no power-up and change the multiplier and alert
	rotate_timer.stop()
	POWERUP_STATE.set_current_powerup("none")
	ScoreSingleton.change_multiplier(1)
	AlertMediatorSingleton.remove_alert()
