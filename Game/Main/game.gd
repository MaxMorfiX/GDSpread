extends Node2D

class_name GameManager

enum State {PLAYER_MOVE, EXPLOSIONS}
var state: State = State.PLAYER_MOVE

#const Player = preload('res://Game/player.gd')
var players : Array[Player] = []
var curr_player: int = 0

var curr_turn : int = 0
var game_ended: bool = false

var paused: bool = false

#const Cell = preload('res://Game/Cell/cell.tscn')
var cells: Array[Cell]

@onready var flying_blocks_container : Node2D = get_node('FlyingBlocksContainer')
@onready var pause_menu : Control = get_node('CanvasLayer/PauseMenu')
@onready var leaderboard: Leaderboard = get_node('CanvasLayer/LeaderboardCenterContainer')
@onready var tutorial: Tutorial = get_node('CanvasLayer/HintCenterContainer')


func _ready() -> void:
	
	#I do it because godot doesn't сopy players own objects
	for player in GameSettings.players:
		players.append(Player.new(player.color))
	
	players.shuffle()
	
	cells = get_node("Map").generate_map()
	get_node('BackgroundCanvas/Background').self_modulate = saturate_player_color(players[curr_player].color)
	
	leaderboard.load_players(players)
	leaderboard.resize_background_properly()

func _input(ev):
	
	if !OS.is_debug_build(): return
	
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
	
func _process(_delta: float) -> void:
	handle_players()
	
	if state != State.EXPLOSIONS: return
	
	if check_next_player(): next_player()
	else: tutorial.cell_exploded()

func check_next_player():
	
	var game_node: GameManager = get_tree().current_scene
	
	return game_node.flying_blocks_container.get_children().size() == 0

func next_player():
	state = State.PLAYER_MOVE
	
	curr_player += 1
	
	if curr_player >= players.size():
		curr_player = 0
		curr_turn += 1
		
		if curr_turn == 1:
			tutorial.first_round_was_played()
	
	if !players[curr_player].is_active:
		next_player()
		
	if GameSettings.gamemode == GameSettings.GAMEMODE.BLOCKED_CELLS:
		if !check_can_player_place_a_block(curr_player):
			next_player()
	
	var bg: TextureRect = get_tree().current_scene.get_node("BackgroundCanvas/Background")
	
	var color: Color = players[curr_player].color
	color = saturate_player_color(color)
	
	bg.self_modulate = color
	
	tutorial.next_player_started()

func check_can_player_place_a_block(pId: int):
	for cell in cells:
		if cell.is_blocked:
			continue
		if cell.player == pId:
			return true
		if cell.energy == 0:
			return true
	
	return false

func handle_players():
	
	update_player_leaderboard()
	
	#yes I know that this code is complex and shitty but I'm too lazy now to fix it for now
	#Yahoo it became more complex with this commit!
	
	if game_ended: return
	
	if curr_turn < 1: return
	
	#var blocks : Array[Node] = get_node('/root/MainGame/FlyingBlocksContainer').get_children()
	
	for pId in range(players.size()): #player dies if there're no his cells
		if players[pId].blocks_count == 0:
			
			players[pId].is_active = false
			
			leaderboard.die_player(pId)
			
	var players_active : int = 0
	var last_player : int = 0 #only used when some player won the game
	
	for pId in range(players.size()):
		
		var player: Player = players[pId]
		
#		print("player " + str(pId) + " is " + str(player.is_active))
		
		if player.is_active:
			players_active += 1
			last_player = pId
			
#	print("players left: " + str(players_active))
	
	if players_active < 2:
		
		game_ended = true
		%GameWinMenu.win_player(last_player)

func update_player_leaderboard():
	var cells_occupied: Array[int] = []
	var blocks_counts: Array[int] = []
	
	for player in players:
		cells_occupied.append(player.cells_occupied)
		blocks_counts.append(player.blocks_count)
	
	leaderboard.update_player_scores(cells_occupied, blocks_counts)

#UI FUNCTIONS

func _toggle_pause():
	_set_paused(not paused)

func _set_paused(value: bool) -> void:
	paused = value
	get_tree().paused = paused
	pause_menu.visible = paused

func _restart_game() -> void:
	_set_paused(false)
	get_tree().reload_current_scene()

func _go_to_main_menu() -> void:
	_set_paused(false)
	get_tree().change_scene_to_file('res://Menus/MainMenu/MainMenu.tscn')

func hide_game_win_menu() -> void:
	%GameWinMenu.hide()
	%PauseButton.show()

func saturate_player_color(color: Color) -> Color:
	
	var col: Color = Color(color)
	
	col.s -= GameSettings.player_color_saturation_factor
	
	return col
