extends TextureRect

var hue = 0.0
var saturation = 1.5
var value = 1.0
var speed = 0.05

var animatedColor = Color(0, 0, 0)

func _process(delta):
	hue += speed * delta
	if hue > 1.0:
		hue -= 1.0

	animatedColor = Color.from_hsv(hue, saturation, value)
	self_modulate = animatedColor
