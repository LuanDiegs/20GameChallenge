extends CharacterBody2D
class_name DineCharacter

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var collision_area = $Area/Collision

signal characterDead

var isDead = false
var positionToDeleteCharacter = 0


func _ready():
	positionToDeleteCharacter = get_viewport_rect().size.y + 100

	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	change_rotation()
	move_and_slide()
	
	if global_position.y > positionToDeleteCharacter and !isDead:
		character_dead()
		queue_free()


func change_rotation():
	if rotation_degrees <= 45:
		rotation_degrees += 1.0
	

func _input(event):
	if event.is_action_pressed("jump") and !isDead:
		velocity.y = -500
		rotation_degrees = lerp(rotation_degrees, -45.0, 1)


func character_dead():
	velocity.y = 0
	isDead = true
	characterDead.emit()


func _on_area_body_entered(body):
	if body.is_in_group("Pipe") and !isDead:
		character_dead()	
		
		
func _on_area_area_entered(area):
	if area.is_in_group("Point"):
		if !isDead:
			Score.increment_score()
