extends Node2D

var block
# Called when the node enters the scene tree for the first time.
func _ready():
	block = preload("res://Prefabs/I-Block.tscn").instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
# Create instance of a scene.
	add_child(block)
	
	
