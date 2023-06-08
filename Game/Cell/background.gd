extends Sprite2D

@export var size = 190
@export var radius = 45

func _draw() -> void:
	var style_box = StyleBoxFlat.new()
	style_box.set_corner_radius_all(radius)
	draw_style_box(style_box, Rect2(Vector2(-size/2.0, -size/2.0), Vector2(size, size)))
