extends Node2D
@export var playerCount: TextEdit

func _ready():
	$Song.play()
	playerCount.insert_line_at(0, "Current Player Count: 4")

func _on_quit_pressed():
	$Bye.play()
	await get_tree().create_timer(1.3).timeout
	get_tree().quit()


func _on_play_pressed():
	$PlayGame.play()
	await get_tree().create_timer(.25).timeout
	get_tree().change_scene_to_file("res://main_scene.tscn")


func _on_player4_pressed():
	GlobalData.setPlayerCount(4) # Replace with function body.
	playerCount.clear()
	playerCount.insert_line_at(0, "Current Player Count: 4")


func _on_player3_pressed():
	GlobalData.setPlayerCount(3)
	playerCount.clear()
	playerCount.insert_line_at(0, "Current Player Count: 3")


func _on_player2_pressed():
	GlobalData.setPlayerCount(2)
	playerCount.clear()
	playerCount.insert_line_at(0, "Current Player Count: 2")
