extends RigidBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

var direction = 0

var isDashing = false
var dashCoolingdown = false
var isJumping = false
var isStunned = false

@export var keyboard_jump : String
@export var keyboard_dash : String
@export var keyboard_right : String
@export var keyboard_left : String

@export var controller_jump : String
@export var controller_dash : String
@export var controller_right : String
@export var controller_left : String

@onready var anim = get_node("PlayerAnim")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")
	self.lock_rotation = true;
	self.set_meta("type", "player")    # set myNode type to "enemy"
	

func _on_body_entered(body):
	var getType = body.get_meta("type") # get the type of myNode
	if (getType != "invisWall"):
		isJumping = false;

	if(getType != "grid" && isDashing): # && get_linear_velocity().x < 20 && get_linear_velocity().x > -20
		isStunned = true
		isDashing = false
		body.apply_central_impulse(Vector2(SPEED * direction,0))
		self.apply_central_impulse(Vector2(SPEED * 2 * -direction,0))
		$bounce.play()

		
	#isDashing = false;

func _on_hurtbox_area_entered(area): # checks to see if the hitbox intercets a hurtbox and kills the player
	var getHitBox = area.get_meta("hitbox")
	if(getHitBox == "block"):
		$death.play()
		self.queue_free() #kills player

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	var isW = Input.is_action_pressed(keyboard_jump)
	var isS = Input.is_action_just_pressed(keyboard_dash)
	var isA = Input.is_action_pressed(keyboard_left)
	var isD = Input.is_action_pressed(keyboard_right)
	var yVel = self.get_linear_velocity().y
	
	if (isW && !isJumping && yVel <= 10): #Jumping
		isJumping = true
		yVel = -400
		self.apply_central_impulse(Vector2(0, yVel))
		$jump.play()
		
	if isD && !isA && !isDashing && !isStunned: #Move Right
		anim.play("Run")
		self.set_linear_velocity(Vector2(SPEED, yVel))
		
	elif isA && !isD && !isDashing && !isStunned: #Move Left
		anim.play("Run")
		self.set_linear_velocity(Vector2(-SPEED,yVel))
		
	else: #Not Moving
		anim.play("Idle")
		
	if isS && isD && !isDashing && !isStunned:
		isDashing = true
		dashCoolingdown = true
		self.apply_central_impulse(Vector2(SPEED * 1.2,0))
		$dash.play()
	
	elif isS && isA && !isDashing && !isStunned:
		isDashing = true
		dashCoolingdown = true
		self.apply_central_impulse(Vector2(-SPEED * 1.2,0))
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

func getDirection(): #Gets the direction the player is moving in on the x-axis
	var d
	if(self.get_linear_velocity().x > 0):
		d = 1;
	
	elif(self.get_linear_velocity().x < 0): 
		d = -1;
	
	else:
		d = 0;
	return d
