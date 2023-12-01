@tool

extends Control

class_name PlayerIconCustomColor

@export var radius: int :
	get:
		return _radius
	set(val):
		_radius = val
		queue_redraw()
@export var color: Color :
	get:
		return _color
	set(val):
#		print(val)
		_color = val
		queue_redraw()

var _color: Color
var _radius: int



func _draw() -> void:
	
	var style_box: StyleBoxFlat = StyleBoxFlat.new()
	style_box.set_corner_radius_all(_radius)
	style_box.bg_color = _color
#	draw_style_box(style_box, Rect2(Vector2(-size.x/2.0, -size.y/2.0), Vector2(size.x, size.y)))
	draw_style_box(style_box, Rect2(Vector2(0, 0), Vector2(size.x, size.y)))
