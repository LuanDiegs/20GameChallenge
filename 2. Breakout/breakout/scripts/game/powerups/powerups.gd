extends Node2D
class_name PowerUps


const POWER_UPS_DIC := [{
	"image": preload("res://assets/game/powerups/expand.png"),
	"name": PowerupsMediator.EXPAND
}, {
	"image": preload("res://assets/game/powerups/doubleball.png"),
	"name": PowerupsMediator.DOUBLE_BALL
}, {
	"image": preload("res://assets/game/powerups/rotate.png"),
	"name": PowerupsMediator.ROTATE
}]


@onready var sprite = $Sprite
var power_up := {}

func _ready():
	# Get random power_up to spawn and set a image
	power_up = POWER_UPS_DIC[randi_range(0, POWER_UPS_DIC.size() - 1)]
	sprite.texture = power_up.image


func _process(delta):
	position.y += 500 * delta


func configure_power_up(initial_position: Vector2):
	self.global_position = initial_position


func _on_area_2d_body_entered(body):
	if(body.is_in_group(GroupsSingleton.PaddleGroup)):
		var paddle = body as Player
		paddle.set_power_up_active(power_up)
			
		queue_free()
