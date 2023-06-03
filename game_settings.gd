extends Node

var Player = preload("res://Game/player.gd")

var rng = RandomNumberGenerator.new()
var player_colors_seed = 1234

var players : Array[Player]
var map_size : int = 3

var players_count : int :
	set(value):
		players = create_players(value)
	get:
		return players.size()

func _init() -> void:
	players_count = 2

func get_player_color(player_id: int, players_in_game: int) -> Color:

	rng.seed = player_colors_seed
	
	var hue: float = float(player_id)/float(players_in_game)
	
	var color = Color.from_hsv(hue, 1, 1, 1)
	
	print(color)
	
	return color

func create_players(count: int) -> Array[Player]:
	
	var plrs: Array[Player] = []
	
	for i in range(count):
		
		var color: Color = get_player_color(i, count)
		
		plrs.push_back(Player.new(color))
		
	return plrs
	
#I still didn't implemented saving
