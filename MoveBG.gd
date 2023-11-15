extends Sprite2D

var speed = 0.25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (position.y >= 108):
		position.y = -178;
	position.y += speed;
