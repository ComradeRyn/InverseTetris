extends Node

var rankings: int
var color: Color
var numPlayers = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setColor(NewColor):
	color = NewColor

func setRank(newRank):
	rankings = newRank

func setPlayerCount(newCount):
	numPlayers = newCount
