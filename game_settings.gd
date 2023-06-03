extends Node

var Player = preload("res://Game/player.gd")

var rng = RandomNumberGenerator.new()
var player_colors_seed = 1234

var players : Array[Player] = [
	Player.new(Color8(0, 0, 255)),
	Player.new(Color8(255, 0, 0)),
	Player.new(Color8(0, 255, 0))
]
var map_size : int = 3

var players_count : int :
	set(value):
		players = create_players(value)
	get:
		return players.size()

func get_player_color(player_id: int, players_in_game: int) -> Color:

	rng.seed = player_colors_seed
	
	var hue: float = float(player_id)/float(players_in_game)
	
	var color = Color.from_hsv(hue, 1, 1, 1)
	
	print("player id: " + str(player_id) + ", players in game: " + str(players_in_game))
	
	return color

func create_players(count: int) -> Array[Player]:
	
	var plrs: Array[Player] = []
	
	for i in range(count):
		
		var color: Color = get_player_color(i, count)
		
		plrs.push_back(Player.new(color))
		
	return plrs
	
#I still didn't implemented saving
