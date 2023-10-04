extends RigidBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = 0
var invdirection = direction * -1
var isDashing = false
var yVel = 0;
var isJumping = false
var temp = 0;
var isBouncing = false
@onready var anim = get_node("PlayerAnim")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")
	self.lock_rotation = true;
	self.set_meta("type", "player")    # set myNode type to "enemy"
	

func _on_body_entered(body):
	var getType = body.get_meta("type") # get the type of myNode
	isJumping = false;
	print(getType)
	if(getType != "grid" && (isDashing)):
		isBouncing = true
		body.apply_central_impulse(Vector2(300 * direction,0))
		self.apply_central_impulse(Vector2(300 * 2 * invdirection,0))
		print("sus")
		
	if(getType == "block"):
		print(getType)
		
	isDashing = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	var isW = Input.is_physical_key_pressed(KEY_W)
	var isS = Input.is_physical_key_pressed(KEY_S)
	var isA = Input.is_physical_key_pressed(KEY_A)
	var isD = Input.is_physical_key_pressed(KEY_D)
	var yVel = self.get_linear_velocity().y
	invdirection = direction * -1
	print(direction)
	
	#print(isJumping)
	# Handle Jump.
	if (isW && !isJumping):
		isJumping = true;
	#	justJumped = true;
		yVel = -400
		self.apply_central_impulse(Vector2(0, yVel))
		
	
	#Left and right movement controls
	if isD && !isDashing && !isBouncing:
		anim.play("Run")
		temp = SPEED
		self.set_linear_velocity(Vector2(SPEED, yVel))
		
	elif isA && !isDashing && !isBouncing:
		anim.play("Run")
		temp = -SPEED
		self.set_linear_velocity(Vector2(-SPEED,yVel))
	
	else:
		anim.play("Idle")
	#Dashing Controls
	if isS && isD && !isDashing:
		isDashing = true
		self.apply_central_impulse(Vector2(SPEED * 1.2,0))
	
	elif isS && isA && !isDashing:
		isDashing = true
		temp = -SPEED * 1.5
		self.apply_central_impulse(Vector2(-SPEED * 1.2,0))
	
	#Dash check to allow dashing again
	if(isDashing && (self.get_linear_velocity().x < 10 && self.get_linear_velocity().x > -10)):
		isDashing = false
	
	if(self.get_linear_velocity().x > 0):
		direction = 1;
	
	elif(self.get_linear_velocity().x > 0): 
		direction = -1;
	
	else:
		direction = 0;
	
	if(isBouncing):
		await get_tree().create_timer(1).timeout
		isBouncing = false
		



