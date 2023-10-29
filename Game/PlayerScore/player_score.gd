extends HBoxContainer

@onready var score_label: Label = $Label

func set_score(blocks_count: int, cells_occupied: int) -> void:
	var text: String = str(blocks_count) + "/" + str(cells_occupied)
	score_label.text = text
