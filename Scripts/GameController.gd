extends Node2D

var numOfPlayers = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(numOfPlayers)
	if(Input.is_action_just_pressed("restart") || numOfPlayers == 0):
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()



func _on_player_tree_exited():
	numOfPlayers -= 1 # Replace with function body.
	$Boom.play()


func _on_player_2_tree_exited():
	numOfPlayers -= 1 # Replace with function body.
	$Boom.play()


func _on_player_3_tree_exited():
	numOfPlayers -= 1 # Replace with function body.
	$Boom.play()


func _on_player_4_tree_exited():
	numOfPlayers -= 1 # Replace with function body.
	$Boom.play()
