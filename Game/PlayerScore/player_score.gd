extends HBoxContainer

class_name PlayerScoreLabel

const PlayerIconCustomColor = preload("res://Game/PlayerScore/PlayerIconCustomColorRect.gd")

@onready var score_label: Label = $Label
@onready var player_color_node: PlayerIconCustomColor = $AspectRatioContainer/PlayerIconCustomColorRect

func set_score(blocks_count: int, cells_occupied: int) -> void:
	var text: String = str(blocks_count) + "/" + str(cells_occupied)
	score_label.text = text

func set_color(color: Color) -> void:
#	print(color)
	player_color_node.color = color
