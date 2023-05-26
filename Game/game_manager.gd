extends Node

var Player = preload('res://Game/player.gd')

var players: Array[Player] = [
	Player.new(Color(12, 0, 255, 255)),
	Player.new(Color(0, 255, 0, 255)),
	Player.new(Color(255, 0, 0, 255))
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
	
func _process(_delta: float) -> void:
	if state != State.EXPLOSIONS: return
	if get_tree().current_scene.name != "MainGame": return
	
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
	
	var bg: TextureRect = get_tree().current_scene.get_node("BackgroundCanvas/Background")
	
	var color: Color = players[curr_player].color
	color = saturate_color(color, 1.5)
	
	bg.self_modulate = color

#function below was written by ChatGPT
func saturate_color(color: Color, saturation_factor: float) -> Color:
	var r = color.r
	var g = color.g
	var b = color.b

	var max_component = max(r, g, b)
	var min_component = min(r, g, b)
	var delta = max_component - min_component

	var saturation = delta / max_component

	# Calculate the saturation adjustment
	var adjustment = (saturation_factor - 1.0) * saturation

	r += adjustment * (max_component - r)
	g += adjustment * (max_component - g)
	b += adjustment * (max_component - b)
	
#	print("was: " + str(color) + ", became: " + str(Color(r, g, b, color.a)))

	return Color(r, g, b, color.a)
