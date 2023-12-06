extends Node2D
@export var mini_game_manager: MiniGameManager
var numOfPlayers
var ranking: Array

func _ready():
	mini_game_manager.game_started.connect(_on_mini_game_manager_game_started)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_F11)):
		swap_fullscreen_mode()
	if(numOfPlayers == 1): #win condition
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://winner.tscn")
	if(Input.is_action_just_pressed("restart") || numOfPlayers == 0):
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()


func _on_players_child_exiting_tree(node): #Whenever anything is destroyed from players node, this code runs
	numOfPlayers -= 1
	print(node.playerNumber)
	ranking.push_back(node.playerNumber)
	$Boom.play()
	#MainCamera.apply_shake()
	
func swap_fullscreen_mode():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		

func _on_mini_game_manager_game_started(player_data):
	numOfPlayers = mini_game_manager.get_players().size()


func _on_mini_game_manager_game_ended():
	pass # Replace with function body.
