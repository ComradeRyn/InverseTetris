extends Node2D

var numOfPlayers = 4

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
	$Boom.play()
	#MainCamera.apply_shake()
	
func swap_fullscreen_mode():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
