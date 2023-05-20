extends Node

var players_colors: Array[Color] = [
	Color(127, 0, 255),
	Color(0, 255, 0),
	Color(255, 0, 0),
]

enum State {PLAYER_MOVE, CONSEQUENCE}

var curr_player: int = 0

func _input(ev):
	if ev is InputEventKey and not ev.echo:
		match ev.keycode:
			KEY_1:
				curr_player = 0
			KEY_2:
				curr_player = 1
			KEY_3:
				curr_player = 2
