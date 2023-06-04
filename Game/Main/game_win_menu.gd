extends Control

@onready var game_win_label: Label = $GameWinText	
	
func win_player(player: int) -> void:
	
	var text := "Player " + str(player + 1) + " won the game!"
	game_win_label.text = text
	
	game_win_label.self_modulate = get_tree().current_scene.players[player].color
	
	show()
