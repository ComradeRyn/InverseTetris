extends Camera2D

@export var randomStrength: float = 20
@export var shakeFade: float = 5

var rng = RandomNumberGenerator.new()

var shakeStrength: float = 0.0

func apply_shake():
	shakeStrength = randomStrength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (shakeStrength > 0):
		shakeStrength = lerpf(shakeStrength,0,shakeFade * delta)
		offset = randomOffset()
		
func randomOffset():
	return Vector2 (rng.randf_range(-shakeStrength,shakeStrength),rng.randf_range(-shakeStrength,shakeStrength) )


func _on_players_child_exiting_tree(node):
	apply_shake()
