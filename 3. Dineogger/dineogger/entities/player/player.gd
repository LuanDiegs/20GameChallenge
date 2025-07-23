extends CharacterBody2D
class_name Player

const DISTANCE_MOVEMENT = 32
const SPEED = 5

var target_position: Vector2
var is_moving: bool = false
var is_on_water_tile: bool = false
var is_above_log: bool = false

@onready var player_area: Area2D = $PlayerArea
@export var collision_shape: CollisionShape2D

func _ready() -> void:
	target_position = position
	player_area.body_entered.connect(_on_player_entered)
	player_area.body_exited.connect(_on_player_exited)
	

func _physics_process(delta: float) -> void:
	_move_player(delta)	
	move_and_slide()	
	_verify_collider(delta)


func _move_player(delta: float):
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_just_pressed("Forward"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("Back"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("Left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("Right"):
		direction = Vector2.RIGHT
		
	if direction and !is_moving:
		var possible_target = target_position + Vector2(DISTANCE_MOVEMENT, DISTANCE_MOVEMENT) * direction
		var limits = DISTANCE_MOVEMENT/2
		var is_valid = (
			possible_target.x > 0 - limits and
			possible_target.x < get_viewport_rect().size.x + limits and
			possible_target.y > 0 - limits and 
			possible_target.y < get_viewport_rect().size.y + limits)
			
		# If the target if a valid place, it will put the coordinates in the target_position
		if(is_valid):
			target_position = possible_target
			
		is_moving = true
		collision_shape.disabled = true	
		_animate_jump()	
		direction = Vector2.ZERO
	
	_verify_collider(delta)	
	position = lerp(position, target_position, SPEED * delta)


func _animate_jump():
	# Animate "jump"
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	tween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.3)
	
	var tween2 = create_tween()
	tween2.tween_callback(func(): is_moving = false).set_delay(0.2)
	tween2.tween_callback(func(): collision_shape.disabled = false).set_delay(0.15)


func _on_player_entered(body: Node2D) -> void:
	if body is CarPropClass:	
		get_tree().reload_current_scene()
	elif body is TileMapLayer:
		is_on_water_tile = true


func _on_player_exited(body: Node2D) -> void:
	if body is TileMapLayer:
		is_on_water_tile = false


func _verify_collider(delta: float):
	if !is_on_water_tile:
		return
		
	var bodies := player_area.get_overlapping_bodies()
	var is_above_log := bodies.any(func(body): return body is LogPropClass)
	var is_above_water := bodies.any(func(body): return body is TileMapLayer)
	if is_above_water and is_above_log:
		var log := bodies.filter(func(body): return body is LogPropClass)[0] as LogPropClass
	
		target_position.x = log.global_position.x
		return
	
	if is_above_water and !is_above_log:
		get_tree().reload_current_scene()
		return
