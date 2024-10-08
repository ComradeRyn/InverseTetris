extends RigidBody2D

const LIFETIME = 10

@export var locationsDown : Array #location arrays for the different oreientation of the blocks
@export var locationsUp : Array 
var chosenRot = randi_range(0,3)
var time = 0

func _ready():
	self.set_meta("type", "block")
	if(chosenRot == 0):
		self.set_rotation(0)
	elif(chosenRot == 1):
		self.set_rotation(PI / 2)
	elif(chosenRot == 2):
		self.set_rotation(PI)
	else:
		self.set_rotation(3 * PI/2)


func _physics_process(delta):
	time += delta
	var yVel = get_linear_velocity().y
	set_axis_velocity(Vector2(0, yVel))
	if(yVel <= 10):
		self.set_meta("block", "passive")
	else:
		self.set_meta("block", "hostile")
	if(time >= LIFETIME):
		self.queue_free()
	
