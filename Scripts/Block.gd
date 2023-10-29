extends RigidBody2D


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var yVel = get_linear_velocity().y
	if(yVel <= 0):
		self.set_meta("type", "passive")
	else:
		self.set_meta("type", "hostile")
	await get_tree().create_timer(10).timeout
	self.queue_free()


func _on_body_entered(body):
	if(body.get_meta("type") == "player"):
		print("pp")
	
