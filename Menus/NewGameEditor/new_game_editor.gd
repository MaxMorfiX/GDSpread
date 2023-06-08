extends Node2D

var rng = RandomNumberGenerator.new()

@onready var map_size_node: SpinBox = $Control/MapSize
@onready var players_count_node: SpinBox = $Control/PlayersCount
@onready var blocked_cells_chance_node: SpinBox = $Control/BlockedCellsChance
@onready var gamemode_button: OptionButton = $Control/Gamemode

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
	blocked_cells_chance_node.value = GameSettings.blocked_cell_chance*100
	gamemode_button.select(GameSettings.gamemode)
	
	if GameSettings.gamemode == GameSettings.GAMEMODE.BLOCKED_CELLS:
		blocked_cells_chance_node.show()

func change_gamemode(mode: GameSettings.GAMEMODE):
	GameSettings.gamemode = mode
	
	if mode == GameSettings.GAMEMODE.BLOCKED_CELLS:
		blocked_cells_chance_node.show()
	else:
		blocked_cells_chance_node.hide()

func _on_blocked_cells_chance_value_changed(value: float) -> void:
	GameSettings.blocked_cell_chance = value/100
	
