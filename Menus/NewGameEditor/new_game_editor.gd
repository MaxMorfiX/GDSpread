extends Node2D

var rng = RandomNumberGenerator.new()

func _on_map_size_value_changed(value: float) -> void:
	GameSettings.map_size = int(value)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Main/game.tscn")

func _on_players_count_value_changed(value: int) -> void:
	GameSettings.players_count = value

func _ready() -> void:
	$Control/MapSize.value = GameSettings.map_size
	$Control/PlayersCount.value = GameSettings.players_count
	
