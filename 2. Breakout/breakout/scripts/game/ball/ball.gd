extends RigidBody2D
class_name Ball

const SPEED_BALL := 750
var velocity: Vector2
var velocity_block := 0
func _ready():
	var randomX = randf_range(1, -1)
	velocity = Vector2(randomX, -1) * SPEED_BALL
	
	gravity_scale = 0
	linear_velocity = velocity


func _integrate_forces(state):
	var ball_direction = linear_velocity.normalized() * SPEED_BALL
	
	# This is for the ball don't get stuck in a straight horizontal line
	if(linear_velocity.normalized().x > 0.750 or linear_velocity.normalized().x < -0.750):
		var AxisY = 1 if linear_velocity.normalized().y > 0 else -1
		var DiffY = Vector2(0, 50) * AxisY
		ball_direction += DiffY

	# This is for the ball don't get stuck in a straight vertical line
	if(linear_velocity.normalized().y > 0.999):
		const DiffX = Vector2(250, 0)
		ball_direction += DiffX
		
	linear_velocity = ball_direction
