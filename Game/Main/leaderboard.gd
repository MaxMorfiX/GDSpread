extends CenterContainer

const PlayerScoreLabel = preload("res://Game/PlayerScore/player_score.gd")
#const GameManager = preload("res://Game/Main/game.gd")

#@onready var game: GameManager = get_tree().current_scene
@onready var player_scores_displays: Array[PlayerScoreLabel] = [
	$BackgroundColorRect/VBoxContainer/PlayerScore1,
	$BackgroundColorRect/VBoxContainer/PlayerScore2,
	$BackgroundColorRect/VBoxContainer/PlayerScore3,
	$BackgroundColorRect/VBoxContainer/PlayerScore4,
	$BackgroundColorRect/VBoxContainer/PlayerScore5,
	$BackgroundColorRect/VBoxContainer/PlayerScore6,
	$BackgroundColorRect/VBoxContainer/PlayerScore7
]

func load_players(players) -> void:
	
	for i in range(0, GameSettings.max_players):
		
		if i >= GameSettings.players_count:
			player_scores_displays[i].hide()
			continue
		
		if players[i].is_active:
#			print(i)
			player_scores_displays[i].set_color(players[i].color)
	
	$BackgroundColorRect/VBoxContainer.update_minimum_size()

func resize_background_properly() -> void:
	var size_of_leaderboard: Vector2 = $BackgroundColorRect/VBoxContainer.get_minimum_size()
#	print(size_of_leaderboard)
	$BackgroundColorRect.custom_minimum_size = size_of_leaderboard + Vector2(15, 15)
	
#	print($CanvasLayer/CenterContainer/BackgroundColorRect)
