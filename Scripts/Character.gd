extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const DASHSPEED = 600
const DASHTIME = 0.2

var timeDashing = 0
var dashing = false
var dashCoolingdown = false
var isStunned = false
var grounded = true
var justDashed = false
var dashDirection = 0
var playerNumber #currently a default value that will be changed


@onready var animPlayer = get_node("AnimationPlayer")
@onready var anim = get_node("PlayerAnim")

@export var keyboard_jump : String
@export var keyboard_dash : String
@export var keyboard_right : String
@export var keyboard_left : String

@export var controller_jump : String
@export var controller_dash : String
@export var controller_right : String
@export var controller_left : String



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_axis(keyboard_left, keyboard_right)
	var jump = Input.is_action_pressed(keyboard_jump)
	var dash = Input.is_action_just_pressed(keyboard_dash)
	var justDashed = Input.is_action_just_pressed(keyboard_dash)

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	elif is_on_floor():
		grounded = true

	# Handle Jump.
	if jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animPlayer.play("Jump")
		grounded = false
		$jump.play()
	
	if justDashed:
		dashDirection = direction
		justDashed = false
		
	if dashing:
		animPlayer.play("Dash")
		velocity.x =  dashDirection * DASHSPEED
		timeDashing += delta
	if timeDashing >= DASHTIME:
		dashing = false
		timeDashing = 0
		
	
	# Get the input direction and handle the movement/deceleration.
	if direction && dash && !dashing:
		dashing = true
		$dash.play()
	elif direction && !dashing:
		if grounded:
			animPlayer.play("Run")
		if direction < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
		velocity.x = direction * SPEED
	elif !dashing:
		velocity.x = move_toward(velocity.x, 0, SPEED/10)
		if grounded:
			animPlayer.play("Idle")
	move_and_slide()
