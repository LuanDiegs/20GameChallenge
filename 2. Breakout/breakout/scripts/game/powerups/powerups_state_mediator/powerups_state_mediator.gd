extends Node
class_name PowerUpsStateMediator

@export var paddle: CharacterBody2D

# States
@onready var rotate := $Rotate
@onready var expand := $Expand

var current_powerup: State = null

func set_current_powerup(powerup: String):
	var powerup_to_change = null
	
	if(powerup == PowerupsMediator.ROTATE):
		powerup_to_change = rotate 
	if(powerup == PowerupsMediator.EXPAND):
		powerup_to_change = expand
		
	current_powerup = powerup_to_change
	if(!powerup_to_change):
		return
		
	current_powerup.enter()


func _physics_process(delta):
	if(current_powerup):
		current_powerup.update()
