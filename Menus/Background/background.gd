extends TextureRect

var hue: float = 0.0
var saturation: float = 1 - GameSettings.player_color_saturation_factor
var value: float = 1.0
var speed: float = 0.05

var animatedColor: Color = Color(0, 0, 0)

func _process(delta):
	hue += speed * delta
	if hue > 1.0:
		hue -= 1.0

	animatedColor = Color.from_hsv(hue, saturation, value)
	self_modulate = animatedColor
