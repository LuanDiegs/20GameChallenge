extends RigidBody2D
class_name Ball

var speed_ball := 750
var velocity: Vector2
var velocity_block := 0

# The maximun of balls in screen is 5, its enough
var MAX_BALLS_IN_SCREEN := 5

func _ready():
	var randomX = randf_range(1, -1)
	velocity = Vector2(randomX, -1) * speed_ball
	
	gravity_scale = 0
	linear_velocity = velocity
	
	PowerupsMediator.set_powerup_double_ball.connect(duplicate_ball)


func _integrate_forces(_delta):
	var ball_direction = linear_velocity.normalized() * speed_ball
	
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


func increment_spedd_ball():
	speed_ball += 25


func duplicate_ball():
	var balls_in_screen = get_tree().get_nodes_in_group(GroupsSingleton.BallGroup).size()
	if(balls_in_screen >= MAX_BALLS_IN_SCREEN):
		return
		
	var duplicated_ball = self.duplicate()
	get_parent().call_deferred("add_child", duplicated_ball)
