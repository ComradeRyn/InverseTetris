extends Node2D

func _ready():
	$Song.play()

func _on_quit_pressed():
	$Bye.play()
	await get_tree().create_timer(1.3).timeout
	get_tree().quit()


func _on_play_pressed():
	$PlayGame.play()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://main_scene.tscn")
