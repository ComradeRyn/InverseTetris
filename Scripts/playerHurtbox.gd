extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_meta("hitbox", "player")

func _on_body_entered(body):
	var block = body.get_meta("type")
	if(block == "hostile"):
		self.get_owner().queue_free() #kills player
