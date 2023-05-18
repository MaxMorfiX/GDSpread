extends Node2D

var Cell = preload('res://Game/Cell/cell.tscn')

func _ready() -> void:
	var cell = Cell.instantiate()
	cell.translate(Vector2(550, 300))
	add_child(cell)
	cell.init([
		true, false, false, true
	])
