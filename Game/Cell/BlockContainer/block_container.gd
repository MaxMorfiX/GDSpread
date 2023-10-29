extends Sprite2D
class_name BlockContainer

const Block = preload('res://Game/Block/block.tscn')

@onready var relative_raw_position := position.normalized()

func get_block() -> Block:
	return get_children()[0]
