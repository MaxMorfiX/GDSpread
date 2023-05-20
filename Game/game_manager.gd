extends Node

var Player = preload('res://Game/player.gd')

var players: Array[Player] = [
	Player.new(Color(127, 0, 255)),
	Player.new(Color(0, 255, 0)),
	Player.new(Color(255, 0, 0))
]

enum State {PLAYER_MOVE, EXPLOSIONS}
var state: State = State.PLAYER_MOVE

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
	
func cell_clicked():
	state = State.EXPLOSIONS
	
func _process(delta: float) -> void:
	if state != State.EXPLOSIONS: return
	
	if check_next_player(): next_player()

func check_next_player():
	
	var game_node = get_tree().current_scene
	
	return game_node.flying_blocks_container.get_children().size() == 0
		
func next_player():
	state = State.PLAYER_MOVE
	
	curr_player += 1
	
	if curr_player >= players.size():
		curr_player = 0
	
	if !players[curr_player].is_active:
		next_player()
