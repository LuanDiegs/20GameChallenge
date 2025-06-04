extends StaticBody2D
class_name Brick

@export var SIZE_WIDTH := 135
@export var SIZE_HEIGHT := 30

@onready var collision_brick: CollisionShape2D = $CollisionBrick
@onready var collision_area_brick: CollisionShape2D = $Area/CollisionAreaBrick

var bounces_to_die: int = 1

signal brick_died

func _ready() -> void:
	var chanceBrickMoreLife = randi_range(1, 100)
	bounces_to_die = 1 if chanceBrickMoreLife <= 70 else 2
	
	# Set the size of the collisions shapes
	collision_area_brick.shape.set("size", Vector2(SIZE_WIDTH, SIZE_HEIGHT))
	collision_brick.shape.set("size", Vector2(SIZE_WIDTH, SIZE_HEIGHT))


func _on_area_body_entered(body: Node2D) -> void:
	# If the ball hits the brick, it disapear
	if(body.is_in_group(GroupsSingleton.BallGroup)):		
		# Decrease life, if 0 the brick dissapears
		bounces_to_die -= 1
		collision_area_brick.debug_color = Color("f82aff6b")
		if (bounces_to_die == 0):
			# Increment score
			brick_died.emit()
			ScoreSingleton.increment_score(1)
			
			# Increment speed ball
			var ball = body as Ball
			ball.increment_spedd_ball()
		
			# See if will spawn power-up
			spawn_power_up()
			
			queue_free()


func spawn_power_up():
	# 45% chance to spawn
	var probability_to_spawn := randi_range(0, 100)
	if(probability_to_spawn <= 45):
		var power_up = preload("res://scenes/game/powerups/powerups.tscn").instantiate()
		var spawner = get_parent() 
		
		power_up.configure_power_up(self.global_position)
	
		spawner.call_deferred("add_child", power_up)
