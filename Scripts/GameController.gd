extends Node2D
@export var mini_game_manager: MiniGameManager
@export var players: Node2D
var numOfPlayers
var ranking: Array #Array which the players will be placed in accending order
var points = [4,3,2,0] #Point values that will be earned depending on the placing
var gameStarted = false #Checks to see if the game started

func _ready():
	mini_game_manager.game_started.connect(_on_mini_game_manager_game_started) #Connects the game_started singnal

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gameStarted):
		if(Input.is_key_pressed(KEY_F11)):
			swap_fullscreen_mode()
		if(numOfPlayers == 1 || Input.is_key_pressed(KEY_0)): #win condition
	#		await get_tree().create_timer(1.5).timeout
	#		get_tree().change_scene_to_file("res://winner.tscn")
			players.get_child(0).queue_free() #Removes the last player and places them as the winner
			await get_tree().create_timer(.25).timeout
			_on_mini_game_manager_game_ended() #ends the game
		if(Input.is_action_just_pressed("restart") || numOfPlayers == 0):
			await get_tree().create_timer(3).timeout
			get_tree().reload_current_scene()
		if(Input.is_key_pressed(KEY_9)):
			mini_game_manager.end_game()


func _on_players_child_exiting_tree(node): #Whenever anything is destroyed from players node, this code runs
	numOfPlayers -= 1
	ranking.push_front(node.playerNumber) #Places the player that just died into the ranking array
	print(node.playerNumber)
	$Boom.play()
	#MainCamera.apply_shake()
	
func swap_fullscreen_mode():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		

func _on_mini_game_manager_game_started(player_data):
	numOfPlayers = mini_game_manager.get_players().size() #Initializes the number of players

	for player in player_data: #Goes through all the player data
		var currentPlayer
		var playerNum = player.number; #Gets the player number that we are on
		if(playerNum == 1): #Sees which player they are on and creates them
			currentPlayer = preload("res://Prefabs/Players2.0/Player1.tscn").instantiate()
			currentPlayer.set_position(Vector2(-150, -20))
		elif(playerNum == 2):
			currentPlayer = preload("res://Prefabs/Players2.0/Player2.tscn").instantiate()
			currentPlayer.set_position(Vector2(-50, -20))
		elif(playerNum == 3):
			currentPlayer = preload("res://Prefabs/Players2.0/Player3.tscn").instantiate()
			currentPlayer.set_position(Vector2(50, -20))
		elif(playerNum == 4):
			currentPlayer = preload("res://Prefabs/Players2.0/Player4.tscn").instantiate()
			currentPlayer.set_position(Vector2(150, -20))
		players.add_child(currentPlayer) #adds the player to the "Players" node
		currentPlayer.playerNumber = playerNum #Sets their player number
		currentPlayer.modulate = player.color #Sets the color
	gameStarted = true #When the loop terminates, set this to true to start the game


func _on_mini_game_manager_game_ended():
	get_tree().paused = true 

	print(ranking)
	var results = [] #Array that will be returned
	var currentPlayer = ranking.pop_front() #Gets the player who is in first place
	
	while(!ranking.is_empty()):
		results.append(MiniGameManager.PlayerResultData.new(currentPlayer, points.pop_front())) #Places the new player data into results
		currentPlayer = ranking.pop_front() #gets the next player in the ranking list
	
	mini_game_manager.apply_results(results)
	
	mini_game_manager.end_game()
