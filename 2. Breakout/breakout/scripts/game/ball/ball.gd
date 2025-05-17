extends RigidBody2D
class_name Ball

const SPEED_BALL := 750
var velocity := Vector2(1, -1) * SPEED_BALL
var velocity_block := 0
func _ready():
	gravity_scale = 0
	linear_velocity = velocity


func _integrate_forces(state):
	var ball_direction = linear_velocity.normalized() * SPEED_BALL
	
	# This is for the ball don't get stuck in a straight horizontal line
	if(linear_velocity.normalized().x > 0.90):
		ball_direction -= Vector2(25, 0)
	if(linear_velocity.normalized().x < -0.90):
		ball_direction += Vector2(25, 0)
		
	linear_velocity = ball_direction
