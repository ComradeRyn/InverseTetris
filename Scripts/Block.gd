extends RigidBody2D


@export var locationsDown : Array #location arrays for the different oreientation of the blocks
@export var locationsUp : Array 
var chosenRot = randi_range(0,3)

var fallSpeed = 300
var incrementRate = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
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

	# Set an initial linear velocity in the y-direction
	var initial_velocity = Vector2(0, fallSpeed)
	set_linear_velocity(initial_velocity)


func _process(delta):
# Counteract gravity in the x-direction
	var new_velocity = get_linear_velocity()
	new_velocity.x = 0  # Set the x-component to 0 to lock the x-velocity
	set_linear_velocity(new_velocity)
	
	
	var yVel = get_linear_velocity().y
	if(yVel <= 0):
		self.set_meta("block", "passive")
	else:
		self.set_meta("block", "hostile")
	await get_tree().create_timer(10).timeout
	self.queue_free()
	
#func _on_body_entered(body):
	#self.set_deferred("freeze", "true")
