extends Node2D

enum State {PLAYER_MOVE, EXPLOSIONS}
var state: State = State.PLAYER_MOVE

var Player = preload('res://Game/player.gd')
var players : Array[Player] = []
var curr_player: int = 0

var curr_turn : int = 0
var game_ended: bool = false

var Cell = preload('res://Game/Cell/cell.tscn')
var cells: Array[Cell]


@onready var flying_blocks_container : Node2D = get_node('FlyingBlocksContainer')


func _ready() -> void:
	
	#I do it because godot doesn't сopy players own objects
	for player in GameSettings.players:
		players.append(Player.new(player.color))
	
	players.shuffle()
	
	cells = get_node("Map").generate_map()
	get_node('BackgroundCanvas/Background').self_modulate = saturate_player_color(players[curr_player].color)

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

func check_next_player():
	
	var game_node = get_tree().current_scene
	
	return game_node.flying_blocks_container.get_children().size() == 0
		
func next_player():
	state = State.PLAYER_MOVE
	
	curr_player += 1
	
	if curr_player >= players.size():
		curr_player = 0
		curr_turn += 1
	
	if !players[curr_player].is_active:
		next_player()
		
	if GameSettings.gamemode == GameSettings.GAMEMODE.BLOCKED_CELLS:
		if !check_can_player_place_a_block(curr_player):
			next_player()
	
	var bg: TextureRect = get_tree().current_scene.get_node("BackgroundCanvas/Background")
	
	var color: Color = players[curr_player].color
	color = saturate_player_color(color)
	
	bg.self_modulate = color

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
	
	#yes I know that this code is complex and shitty but I'm too lazy now to fix it for now
	#Yahoo it became more complex with this commit!
	
	if game_ended: return
	
	if curr_turn < 1: return
	
	var players_score: Array[int] = []
	
	for i in range(players.size()): #initializing an array with specified size
		players_score.append(0) 
	
	for cell in cells: #counting score (count of cells) of players
		if cell.energy < 1: continue
		
		players_score[cell.player] += 1	
		
#	print(players_score)
	
	for pId in range(players_score.size()): #player dies if there're no his cells
		if players_score[pId] == 0:
			
			players[pId].is_active = false
			
	var blocks : Array[Node] = get_node('/root/MainGame/FlyingBlocksContainer').get_children()
			
	for block in blocks: #counting score (count of cells) of players
		players[block.player].is_active = true
			
	var players_active : int = 0
	var last_player : int = 0 #only used when some player won the game
	
	for pId in range(players.size()):
		
		var player = players[pId]
		
#		print("player " + str(pId) + " is " + str(player.is_active))
		
		if player.is_active:
			players_active += 1
			last_player = pId
			
#	print("players left: " + str(players_active))
	
	if players_active < 2:
		
		game_ended = true
		%GameWinMenu.win_player(last_player)


func _restart_game() -> void:
	get_tree().reload_current_scene()

func _go_to_main_menu() -> void:
	get_tree().change_scene_to_file('res://Menus/MainMenu/MainMenu.tscn')

func hide_game_win_menu() -> void:
	%GameWinMenu.hide()
	%GameButtons.show()

func saturate_player_color(color: Color) -> Color:
	
	var col = Color(color)
	
	col.s -= GameSettings.player_color_saturation_factor
	
	return col
