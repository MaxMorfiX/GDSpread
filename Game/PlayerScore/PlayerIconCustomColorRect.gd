@tool

extends Control

@export var radius: int = 45
@export var color: Color

func _draw() -> void:
	
	var style_box = StyleBoxFlat.new()
	style_box.set_corner_radius_all(radius)
	style_box.bg_color = color
#	draw_style_box(style_box, Rect2(Vector2(-size.x/2.0, -size.y/2.0), Vector2(size.x, size.y)))
	draw_style_box(style_box, Rect2(Vector2(0, 0), Vector2(size.x, size.y)))
