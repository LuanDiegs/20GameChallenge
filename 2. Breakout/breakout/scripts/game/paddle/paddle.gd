extends CharacterBody2D
class_name Player

const SPEED:float = 500.0

var inicial_y_position: float
var clicking := false

# PowerUps states
@onready var power_ups_actives = $PowerUpsActives

# Visual
@onready var color_rect = $Sprite/ColorRect
@onready var colission = $Colission


func _ready():
	var size = Vector2(200, 40)
	set_size(size)
	
	inicial_y_position = self.position.y


func _physics_process(_delta):
	_move_paddle()
	move_and_slide()


func _move_paddle():	
	position.y = inicial_y_position
	
	var direction = Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("click"):
		direction = 1 if get_global_mouse_position() > self.global_position else -1
		velocity.x = direction * SPEED


func set_power_up_active(power_up: Dictionary):
	power_ups_actives.set_current_powerup(power_up.name)
	
	print(power_up.name)
	if(power_up.name == PowerupsMediator.DOUBLE_BALL):
		PowerupsMediator.set_powerup_double_ball.emit()


func set_size(size: Vector2):
	color_rect.pivot_offset = size/2
	
	# One tween for each property to do the animation at the same time
	var tween = create_tween()
	tween.tween_property(colission.shape, "size", size, 0.5)
	
	var tween2 = create_tween()
	tween2.tween_property(color_rect, "size", size, 0.5)
	
	var tween3 = create_tween()
	tween3.tween_property(color_rect, "position", -size/2, 0.5)
