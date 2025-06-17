extends PanelContainer
class_name PausedScreen

@onready var title = $Vbox/Title
@onready var sub_title = $Vbox/SubTitle


func _ready():
	GameState.end_game.connect(_game_over_screen)
	GameState.paused_game.connect(_paused_scape)
	GameState.initial_state.connect(_initial_screen_game)
	GameState.start_game.connect(_start_game)


func _start_game():
	# If the game is starded, the screen is not visible
	visible = false
	
	
func _initial_screen_game():	
	self.visible = true
	title.text = "BREAKOUT"
	sub_title.text = 'Click on the screen to start'
	
	process_mode = Node.PROCESS_MODE_INHERIT
	

func _paused_scape():	
	self.visible = true
	title.text = "PAUSED"
	sub_title.text = 'Click on the screen or press "Escape" to continue'
	
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	
func _game_over_screen():	
	self.visible = true
	title.text = "OH NO! You lost :P"
	sub_title.text = 'Click on the screen to retry'
	
	process_mode = Node.PROCESS_MODE_INHERIT


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		# If the game is finished, it will reload the scene
		if GameState.current_state == GameState.GAME_STATES.FINISHED:
			GameState.set_game_state(GameState.GAME_STATES.INITIAL)
			get_tree().call_deferred("reload_current_scene")
			return
		
		# If the game is paused, it will despause
		if GameState.current_state == GameState.GAME_STATES.PAUSED:
			get_tree().set_pause(false)	
			
		GameState.set_game_state(GameState.GAME_STATES.STARTED)
		visible = false  


func _input(event: InputEvent) -> void:
	# Despause game
	if event.is_action_pressed("Pause"):
		if GameState.current_state == GameState.GAME_STATES.PAUSED:
			get_tree().set_pause(false)	
			
			GameState.call_deferred("set_game_state", GameState.GAME_STATES.STARTED)
			visible = false 
