extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_meta("hitbox", "player")

func _on_body_entered(body):
	print("A")
	var block = body.get_meta("block")
	if(block == "hostile"):
		self.get_owner().queue_free() #kills player
