extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_meta("type", "grid") # Replace with function body.
	get_node("Ship").play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
