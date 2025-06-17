extends CharacterBody2D
class_name Player

const SPEED := Vector2(800.0, 0)

var inicial_y_position: float
var clicking := false

const _INITIAL_X_SIZE := 200
const _INITIAL_Y_SIZE := 40

# PowerUps states
@onready var power_ups_actives = $PowerUpsActives

# Visual
@onready var colission = $Colission
@onready var sprite = $Sprite


func _ready():
	var size = Vector2(_INITIAL_X_SIZE, _INITIAL_Y_SIZE)
	set_size(size)
	
	inicial_y_position = self.position.y


func _physics_process(_delta):
	_move_paddle()
	move_and_slide()


func _move_paddle():	
	# If the game is not started, wont`t move the paddle
	if GameState.current_state != GameState.GAME_STATES.STARTED:
		return
		
	position.y = inicial_y_position
	
	var direction = Input.get_axis("esquerda", "direita")
	if direction:
		var velocity_target = direction * SPEED
		velocity = velocity.lerp(velocity_target, 1 - exp(-30 * get_physics_process_delta_time()))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED.x)
		
	if Input.is_action_pressed("click"):
		direction = 1 if get_global_mouse_position() > self.global_position else -1
		var velocity_target = direction * SPEED
		velocity = velocity.lerp(velocity_target, 1 - exp(-300 * get_physics_process_delta_time()))


func set_power_up_active(power_up: Dictionary):
	power_ups_actives.set_current_powerup(power_up.name)
	
	if(power_up.name == PowerupsMediator.DOUBLE_BALL):
		PowerupsMediator.set_powerup_double_ball.emit()


func set_size(size: Vector2):	
	var scale_x = size.x/_INITIAL_X_SIZE
	
	# One tween for each property to do the animation at the same time
	var tween = create_tween()
	tween.tween_property(colission.shape, "size", size, 0.5)
	
	var tween2 = create_tween()
	tween2.tween_property(sprite, "scale", Vector2(scale_x, 1), 0.5)
