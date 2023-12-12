extends Node2D
@export var winnerSprite: Sprite2D
@export var winnerText: TextEdit
var firstPlace = GlobalData.rankings
var firstColor = GlobalData.color
var winningText = "Player " + str(firstPlace) +  " Wins!"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	Engine.time_scale = 1
	$Win.play()
	winnerSprite.modulate = firstColor
	winnerText.insert_line_at(0, winningText)


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://main_scene.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
