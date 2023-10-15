extends Node2D

var block
var spawnBlock = true
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #Spawns blocks infinitely
	if(spawnBlock):
		block = preload("res://Prefabs/I-Block.tscn").instantiate()
		#add_child(block)
		spawnBlock = false
	elif(!spawnBlock):
		await get_tree().create_timer(1).timeout
		spawnBlock = true
