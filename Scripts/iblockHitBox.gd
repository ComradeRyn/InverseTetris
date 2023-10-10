extends Area2D

var getHurt

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_meta("type", "block") # Replace with function body.
	self.set_meta("hitbox", "block")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	getHurt = area.get_meta("hitbox")
	if(getHurt != "player"):
		self.set_deferred("monitorable", false) 
		$death.play()
