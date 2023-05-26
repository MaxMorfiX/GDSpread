extends Node

var Player = preload("res://Game/player.gd")

var players : Array[Player] :
	set(value):
		_players = value
	get:
		return _players
var _players : Array[Player] = [
	Player.new(Color8(0, 0, 255)),
	Player.new(Color8(255, 0, 0))
] 

var map_size : int :
	set(value):
		_map_size = value
	get:
		return _map_size
var _map_size : int = 3

#I still didn't implemented saving
