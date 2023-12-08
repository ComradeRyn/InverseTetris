extends Node2D
@export var mini_game_manager: MiniGameManager
@export var players: Node2D
var numOfPlayers
var playerPrefabs = ["res://Prefabs/Players2.0/Player1.tscn", "res://Prefabs/Players2.0/Player2.tscn",
"res://Prefabs/Players2.0/Player3.tscn", "res://Prefabs/Players2.0/Player4.tscn"]
var ranking: Array
var points = [4,3,2,0]

func _ready():
	mini_game_manager.game_started.connect(_on_mini_game_manager_game_started)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_F11)):
		swap_fullscreen_mode()
	if(numOfPlayers == 1 || Input.is_key_pressed(KEY_0)): #win condition
#		await get_tree().create_timer(1.5).timeout
#		get_tree().change_scene_to_file("res://winner.tscn")
		players.get_child(0).queue_free()
		await get_tree().create_timer(.25).timeout
		_on_mini_game_manager_game_ended()
	if(Input.is_action_just_pressed("restart") || numOfPlayers == 0):
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()


func _on_players_child_exiting_tree(node): #Whenever anything is destroyed from players node, this code runs
	numOfPlayers -= 1
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
	get_tree().paused = true
	var pointsToAward = 4
	
	print(ranking)
	var results = []
	var pointVal = 0
	var i = 1
	var currentPlayer = ranking.pop_front()
	
	while(!ranking.is_empty()):
		results.append(MiniGameManager.PlayerResultData.new(i, 0))
		pointVal+= 1
		currentPlayer = ranking.pop_front()
		i+= 1
	
	mini_game_manager.apply_results(results)
	
	mini_game_manager.end_game()
