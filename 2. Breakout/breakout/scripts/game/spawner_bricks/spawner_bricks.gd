extends Node
class_name SpawnerBricks

const BRICK := preload("res://scenes/game/brick/brick.tscn") 

@export var BRICK_WIDTH := 135.0 
@export var BRICK_HEIGHT := 50.0

@export var BRICK_COLUMNS := 5
@export var BRICK_ROWS := 6
@export var BRICK_SPACING_X := 5.0
@export var BRICK_SPACING_Y := 5.0

# Private
var _bricks_count := 0


func _ready() -> void:
	create_level()
	
	
func create_level():	
	var screen_size_x := get_viewport().get_visible_rect().size.x
	BRICK_COLUMNS = randi_range(3, 6)
	BRICK_ROWS = randi_range(3, 6)
	BRICK_WIDTH = ((screen_size_x - 20) - (BRICK_COLUMNS * BRICK_SPACING_X)) / BRICK_COLUMNS
	
	_bricks_count = BRICK_COLUMNS * BRICK_ROWS
	
	# Calculate the total width occupied by all bricks (including spacing)
	var width_all_bricks := (BRICK_WIDTH * BRICK_COLUMNS) + (BRICK_COLUMNS * BRICK_SPACING_X)

	# Calculate the initial X position to center the brick group on screen:
	# 1. Subtract total bricks width from screen width
	# 2. Divide remaining space by 2 to center
	# 3. Add half brick width and half spacing for fine adjustment
	var initial_x := ((screen_size_x - width_all_bricks) / 2) + (BRICK_WIDTH / 2) + (BRICK_SPACING_X / 2)

	# Fixed initial Y position
	var initial_y := 80

	# Combined initial spawn position
	var initial_position_spawn := Vector2(initial_x, initial_y)

	# Offset for subsequent lines (initialized as 0.0)
	var line_offset_y := 0.0
	
	# Put the columns in the range
	for row in range(BRICK_ROWS):
		var last_brick_x = null
		
		# Put the lines in the range
		for col in range(BRICK_COLUMNS):
			var brick := BRICK.instantiate()
			
			# If the las_brick_x is null, the postion is the initial, if not calculate the post position
			var spawn_pos := initial_position_spawn + Vector2(0, line_offset_y)
			if last_brick_x != null:
				var x_pos = last_brick_x + BRICK_WIDTH + BRICK_SPACING_X
				spawn_pos = Vector2(x_pos, spawn_pos.y)
			
			# Define the position and the size of the brick
			brick.global_position = spawn_pos
			brick.SIZE_WIDTH = BRICK_WIDTH
			brick.SIZE_HEIGHT = BRICK_HEIGHT
			last_brick_x = brick.global_position.x
			brick.connect("brick_died", _brick_died)
			call_deferred("add_child", brick)
			
		line_offset_y += BRICK_HEIGHT + BRICK_SPACING_Y


func _brick_died():
	_bricks_count -= 1
	
	# If theres no bricks left, the level is recreated
	if(_bricks_count == 0):
		create_level()
