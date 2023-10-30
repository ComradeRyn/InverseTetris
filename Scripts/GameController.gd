extends Node2D

var numOfPlayers = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(numOfPlayers)
	if(Input.is_action_just_pressed("restart") || numOfPlayers == 0):
		get_tree().reload_current_scene()
