extends Node2D
class_name MovementPropsClass

@export var entity: PropBaseClass
@export var speed: int = 100
@export var entity_sprite: Sprite2D


func _ready() -> void:
	entity_sprite.flip_h = entity.movement_direction == 1


func _process(delta: float) -> void:
	entity.position += Vector2(speed * delta * entity.movement_direction, 0)
