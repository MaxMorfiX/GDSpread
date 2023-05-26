extends Node2D


func _on_map_size_value_changed(value: float) -> void:
	GameSettings.map_size = int(value)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Main/game.tscn")
