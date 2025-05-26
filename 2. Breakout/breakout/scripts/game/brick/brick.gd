extends StaticBody2D
class_name Brick

@export var SIZE_WIDTH := 135
@export var SIZE_HEIGHT := 30

@onready var collision_brick: CollisionShape2D = $CollisionBrick
@onready var collision_area_brick: CollisionShape2D = $Area/CollisionAreaBrick


func _ready() -> void:
	#Set the size of the collisions shapes
	collision_area_brick.shape.set("size", Vector2(SIZE_WIDTH, SIZE_HEIGHT))
	collision_brick.shape.set("size", Vector2(SIZE_WIDTH, SIZE_HEIGHT))


func _on_area_body_entered(body: Node2D) -> void:
	# If the ball hits the brick they disapear
	if(body.is_in_group(GroupsSingleton.BallGroup)):
		queue_free()
