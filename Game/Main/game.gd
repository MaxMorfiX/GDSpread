extends Node2D

var Cell = preload('res://Game/Cell/cell.tscn')

var cells: Array

func _ready() -> void:
	cells = get_node("Map").generate_map(7)
