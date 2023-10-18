extends Area2D

var body

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_meta("type", "block") # Replace with function body.
	self.set_meta("hitbox", "block")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	body = area.get_meta("hitbox")
	if(body != "player"):
		self.set_deferred("monitorable", false)
	elif(body == "player" && self.monitorable):
		$death.play()
	await get_tree().create_timer(3).timeout
	self.get_owner().queue_free()
