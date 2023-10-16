extends Node2D

var block
var spawnBlock = false
var spawnRate = 1
# Called when the node enters the scene tree for the first time.
func _ready(): #Waits before spawning first block
	await get_tree().create_timer(spawnRate).timeout
	spawnBlock = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(spawnBlock): 
		block = preload("res://Prefabs/I-Block.tscn").instantiate() #Replace with method that picks random location to spawn block
		add_child(block)
		spawnBlock = false
		$place.play()
		await get_tree().create_timer(spawnRate).timeout
		spawnBlock = true
		
