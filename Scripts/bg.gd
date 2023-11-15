extends ParallaxBackground

var scrollSpeed = 100;

func _process(delta):
	scroll_base_offset.y += scrollSpeed * delta
