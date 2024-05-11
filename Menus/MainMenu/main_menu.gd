extends Node



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/NewGameEditor/NewGameEditor.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _ready() -> void:	
	
	var os: String = OS.get_name()
	
	if os == "HTML5" or os == "Web":
		$CenterContainer/VBoxContainer/ExitButton.hide()


func _on_tutorial_button_pressed() -> void:
	GameSettings.players_count = 2
	GameSettings.map_size = 3
	GameSettings.gamemode = GameSettings.GAMEMODE.TUTORIAL
	get_tree().change_scene_to_file("res://Game/Main/game.tscn")
