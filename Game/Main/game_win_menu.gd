extends Control

@onready var game_win_label: Label = $GameWinText


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file('res://Menus/MainMenu/MainMenu.tscn')
	
	
func win_player(player: int) -> void:
	
	var text := "Player " + str(player + 1) + " won the game!"
	game_win_label.text = text
	
	game_win_label.self_modulate = Game.players[player].color
	
	show()
