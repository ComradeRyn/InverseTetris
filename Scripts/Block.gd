extends RigidBody2D


var locationsDown = [-160, -96, -32, 32, 96, 160]
var locationsUp = [-200, -180, -160, -140, -120, -100, -80, -60, -40, -20, 0, 20, 40, 60, 80, 100, 120, 140, 160, 180]
var chosenRot = randi_range(0,3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	if(chosenRot == 0):
		self.set_rotation(0)
	elif(chosenRot == 1):
		self.set_rotation(PI / 2)
	elif(chosenRot == 2):
		self.set_rotation(PI)
	else:
		self.set_rotation(3 * PI/2)

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
	
