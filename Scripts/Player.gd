extends RigidBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

var direction = 0

var isDashing = false
var dashCoolingdown = false
var grounded = true
var jumpCooldown = false
var isStunned = false

@export var keyboard_jump : String
@export var keyboard_dash : String
@export var keyboard_right : String
@export var keyboard_left : String

@export var controller_jump : String
@export var controller_dash : String
@export var controller_right : String
@export var controller_left : String

@onready var animPlayer = get_node("AnimationPlayer")
@onready var anim = get_node("PlayerAnim")

# Called when the node enters the scene tree for the first time.
func _ready():
	animPlayer.play("Idle")
	self.lock_rotation = true;
	self.set_meta("type", "player")    # set myNode type to "enemy"
	

func _on_body_entered(body):
	var getType = body.get_meta("type") # get the type of myNode
	if (getType != "invisWall" && !jumpCooldown):
		grounded = true;
	#if(getType == "block"):
		#self.queue_free()

	if(getType != "grid" && isDashing && getType != "player"): # && get_linear_velocity().x < 20 && get_linear_velocity().x > -20
		isStunned = true
		isDashing = false
		body.apply_central_impulse(Vector2(SPEED * direction,0))
		self.apply_central_impulse(Vector2(SPEED * 2 * -direction,0))
		$bounce.play()
	
	if(getType == "player" && isDashing): # && get_linear_velocity().x < 20 && get_linear_velocity().x > -20
		body.isStunned = true
		isStunned = true
		isDashing = false
		body.apply_central_impulse(Vector2(SPEED * direction,0))
		self.apply_central_impulse(Vector2(SPEED * 2 * -direction,0))
		$bounce.play()
		await get_tree().create_timer(0.25).timeout
		isStunned = false
		
	#isDashing = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	var isW = Input.is_action_pressed(keyboard_jump)
	var isS = Input.is_action_just_pressed(keyboard_dash)
	var isA = Input.is_action_pressed(keyboard_left)
	var isD = Input.is_action_pressed(keyboard_right)
	var yVel = self.get_linear_velocity().y
	
	if (isW && grounded && !jumpCooldown): #Jumping
		#animPlayer.play("Jump")
		grounded = false;
		jumpCooldown = true;
		yVel = -400
		self.apply_central_impulse(Vector2(0, yVel))
		$jump.play()
	
	if(yVel >= 0):
		pass
		#animPlayer.play("Fall")
	if(get_colliding_bodies().size() == 0): #Doesnt account for celeste
		grounded = false;
		
	if isD && !isA && !isDashing && !isStunned: #Move Right
		anim.flip_h = false 
		if grounded:
			pass
			#animPlayer.play("Run")
		self.set_linear_velocity(Vector2(SPEED, yVel))
		
	elif isA && !isD && !isDashing && !isStunned: #Move Left
		anim.flip_h = true #flip sprite direction
		if grounded:
			pass
			#animPlayer.play("Run")
		self.set_linear_velocity(Vector2(-SPEED,yVel))
		
	else: #Not Moving
		if !isDashing:
			animPlayer.play("Idle")
		if(!isDashing && !isStunned):
			self.set_linear_velocity(Vector2(0,yVel));
		
	if isS && isD && !isDashing && !isStunned:
		animPlayer.play("Dash")
		isDashing = true
		dashCoolingdown = true
		self.apply_central_impulse(Vector2(SPEED * 1.05,0))
		$dash.play()
	
	elif isS && isA && !isDashing && !isStunned:
		animPlayer.play("Dash")
		isDashing = true
		dashCoolingdown = true
		self.apply_central_impulse(Vector2(-SPEED * 1.05,0))
		$dash.play()
	
	#Dash check to allow dashing again
	if(isDashing && (self.get_linear_velocity().x < 100 && self.get_linear_velocity().x > -100)):
		isDashing = false
	
	direction = getDirection()
	
	if(isStunned):
		await get_tree().create_timer(0.5).timeout
		isStunned = false
		
	if(isDashing):
		await get_tree().create_timer(0.5).timeout
		dashCoolingdown = false
		
	if(jumpCooldown):
		await get_tree().create_timer(0.25).timeout
		jumpCooldown = false

func getDirection(): #Gets the direction the player is moving in on the x-axis
	var d
	if(self.get_linear_velocity().x > 0):
		d = 1;
	
	elif(self.get_linear_velocity().x < 0): 
		d = -1;
	
	else:
		d = 0;
	return d

