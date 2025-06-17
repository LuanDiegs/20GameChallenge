extends State
class_name ExpandState

@export var POWERUP_STATE: PowerUpsStateMediator
@export var POWERUP_DURATION := 5.0

@onready var expand_timer = $ExpandTimer


func _ready():
	expand_timer.wait_time = POWERUP_DURATION
	expand_timer.connect("timeout", timeout_powerup)
	

func update():
	pass
	
	
func enter():
	expand_timer.start()
	
	#Expand paddle
	var paddle = POWERUP_STATE.paddle as Player
	var size = Vector2(300, 40)
	paddle.set_size(size)
	
	AlertMediatorSingleton.create_alert("Expand paddle!", POWERUP_DURATION)


func timeout_powerup():
	expand_timer.stop()
	POWERUP_STATE.set_current_powerup("none")
	
	# Set default size of the paddle
	var paddle = POWERUP_STATE.paddle as Player
	var size = Vector2(200, 40)
	paddle.set_size(size)
