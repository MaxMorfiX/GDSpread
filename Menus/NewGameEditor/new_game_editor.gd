extends Node2D

var rng = RandomNumberGenerator.new()

@onready var map_size_node = $Control/MapSize
@onready var players_count_node = $Control/PlayersCount

func _on_map_size_value_changed(value: float) -> void:
	GameSettings.map_size = int(value)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Main/game.tscn")

func _on_players_count_value_changed(value: int) -> void:
	GameSettings.players_count = value
	map_size_node.min_value = int(sqrt(GameSettings.players_count - 1)) + 1 #bc it'll be rounded down

func _ready() -> void:
	map_size_node.value = GameSettings.map_size
	players_count_node.value = GameSettings.players_count

