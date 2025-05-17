extends CharacterBody2D
class_name Player

const SPEED:float = 500.0

var inicial_y_position: float

func _ready():
	inicial_y_position = self.position.y

func _physics_process(_delta):
	_move_paddle()
	_verify_limits_move()
	move_and_slide()


func _move_paddle():	
	position.y = inicial_y_position
	
	var direction = Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _verify_limits_move():
	pass
