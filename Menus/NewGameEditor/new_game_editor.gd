extends Node

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

@onready var map_size_node: Label = $CenterContainer/VBoxContainer/Parameters/MapSizeChooser/Label
@onready var players_count_node: Label = $CenterContainer/VBoxContainer/Parameters/PlayersChooser/Label
#@onready var blocked_cells_chance_node: SpinBox = $Control/BlockedCellsChance
#@onready var gamemode_button: OptionButton = $Control/Gamemode

func _change_players_count(amount: int) -> void:
	if GameSettings.players_count + amount > GameSettings.max_players:
		return
	if GameSettings.players_count + amount < 2:
		return
	GameSettings.players_count += amount
	
	players_count_node.text = "Players: " + str(GameSettings.players_count)

func _change_map_size(amount: int) -> void:
	if GameSettings.map_size + amount < 2:
		return
	GameSettings.map_size += amount
	
	map_size_node.text = "Map Size: " + str(GameSettings.map_size)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Main/game.tscn")

func _ready() -> void:
	
	var settings: Dictionary = GamesaveManager.load_dict().game_settings
	
	GameSettings.gamemode = settings.gamemode
	GameSettings.players_count = settings.players_count
	GameSettings.map_size = settings.map_size
	players_count_node.text = "Players: " + str(GameSettings.players_count)
	map_size_node.text = "Map Size: " + str(GameSettings.map_size)

#	blocked_cells_chance_node.value = GameSettings.blocked_cell_chance*100
#	gamemode_button.select(GameSettings.gamemode)

#	if GameSettings.gamemode == GameSettings.GAMEMODE.BLOCKED_CELLS:
#		blocked_cells_chance_node.show()

#func change_gamemode(mode: GameSettings.GAMEMODE):
#	GameSettings.gamemode = mode
#
#	if mode == GameSettings.GAMEMODE.BLOCKED_CELLS:
#		blocked_cells_chance_node.show()
#	else:
#		blocked_cells_chance_node.hide()
#
#func _on_blocked_cells_chance_value_changed(value: float) -> void:
#	GameSettings.blocked_cell_chance = value/100

#func _on_players_count_value_changed(value: int) -> void:
#	GameSettings.players_count = value
#	map_size_node.min_value = int(sqrt(GameSettings.players_count - 1)) + 1 #bc it'll be rounded down
#
#func _on_map_size_value_changed(value: float) -> void:
#	GameSettings.map_size = int(value)
