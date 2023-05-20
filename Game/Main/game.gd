extends Node2D

var Cell = preload('res://Game/Cell/cell.tscn')

@onready var flying_blocks_container : Node2D = get_node('FlyingBlocksContainer')

var cells: Array

func _ready() -> void:
	cells = get_node("Map").generate_map(7)
