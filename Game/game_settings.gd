extends Node

const max_players : int = 7
const player_color_saturation_factor: float = 0.35

#const Player = preload("res://Game/player.gd")

enum GAMEMODE {CLASSIC, BLOCKED_CELLS, TUTORIAL}

var gamemode : GAMEMODE = GAMEMODE.CLASSIC
var players : Array[Player]
var map_size : int = 3

var blocked_cell_chance: float = 0.2

@onready var previous_window: DisplayServer.WindowMode = DisplayServer.window_get_mode()
@onready var current_window: DisplayServer.WindowMode = DisplayServer.window_get_mode()



var players_count : int :
	set(value):
		players = create_players(value)
	get:
		return players.size()

func _init() -> void:
	players_count = 2

func generate_player_color(player_id: int, players_in_game: int) -> Color:
	
	var hue: float = float(player_id)/float(players_in_game)
	
	var color: Color = Color.from_hsv(hue, 1, 1, 1)
	
#	print(color)
	
	return color

func create_players(count: int) -> Array[Player]:
	
	var plrs: Array[Player] = []
	
	for i in range(count):
		
		var color: Color = generate_player_color(i, count)
		
		plrs.push_back(Player.new(color))
		
	return plrs


func _input(_event):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		current_window = DisplayServer.window_get_mode()
		if current_window != DisplayServer.WINDOW_MODE_FULLSCREEN:
			previous_window = current_window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			if previous_window == DisplayServer.WINDOW_MODE_FULLSCREEN:
				previous_window = DisplayServer.WINDOW_MODE_MAXIMIZED
			DisplayServer.window_set_mode(previous_window)

func to_dict() -> Dictionary:
	return {
		"gamemode": gamemode,
		"map_size": map_size,
		"players_count": players_count,
	}

func from_dict(dict: Dictionary) -> void:
	gamemode = dict.gamemode
	map_size = dict.map_size
	players_count = dict.players_count
