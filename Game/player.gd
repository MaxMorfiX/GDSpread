extends Node
class_name Player

var color: Color = Color()
var is_active: bool = true

func _init(color: Color) -> void:
	self.color = color
