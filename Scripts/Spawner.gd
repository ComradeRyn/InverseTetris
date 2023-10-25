extends Node2D

var block
var spawnBlock = false
var spawnRate = 1
var locations = [-160, -96, -32, 32, 96, 160]
var decrementRate = 0.01

func _ready(): #Waits before spawning first block
	await get_tree().create_timer(spawnRate).timeout
	spawnBlock = true


func _process(delta):
	if(spawnBlock): 
		block = preload("res://Prefabs/I-Block.tscn").instantiate() #Replace with method that picks random location to spawn block
		add_child(block)
		var chosenSpot = locations[randi_range(0,locations.size() - 1)]
		block.set_position(Vector2(chosenSpot, 0)) #puts the position 
		spawnBlock = false
		$place.play()
		await get_tree().create_timer(spawnRate).timeout
		spawnBlock = true
		
	var decrementAmount = decrementRate * delta #spawner spawns blocks faster as time goes on
	spawnRate -= decrementAmount
	if spawnRate <= 0.1:
		spawnRate = 0.1
