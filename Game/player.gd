class_name Player

var color: Color = Color()
var is_active: bool = true

var cells_occupied: int = 0
var blocks_count: int = 0

func _init(set_color: Color) -> void:
	color = set_color
