extends Node2D
class_name SpawnerEntity

# Says what direction the car is moving
enum Directions { Right, Left }

@export var direction: Directions
@export var cooldown_spawner: float

@onready var timer_spawner: Timer = $TimerSpawner
@onready var spawner_area: Area2D = $SpawnerArea

@export var ENTITY_SCENE: PackedScene


func _ready() -> void:
	timer_spawner.wait_time = cooldown_spawner
	timer_spawner.start()
	
	timer_spawner.timeout.connect(_spawn_entity)

func _spawn_entity():
	var entity := ENTITY_SCENE.instantiate() as PropBaseClass
	
	entity.movement_direction = 1 if direction == Directions.Right else -1
	spawner_area.add_child(entity)
	
