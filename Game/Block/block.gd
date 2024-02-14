extends Area2D
class_name Block

#const Cell = preload('res://Game/Cell/cell.tscn')
#const GameManager = preload('res://Game/Main/game.gd')

@onready var game: GameManager = get_tree().current_scene
@onready var sprite: Sprite2D = get_node("Sprite2D")

const speed = 300

var is_flying : bool = false

var player : int = -1 #-1 is used for checking is player attached to block
var velocity: Vector2
var distance_flew: float = 0

func _ready() -> void:
	game.players[player].blocks_count += 1

func _physics_process(delta: float) -> void:
	if is_flying:
		var offset: Vector2 = velocity*delta
		
		position += offset
		distance_flew += offset.length()

func throw(direction: Vector2) -> Block:
	velocity = direction*speed
	is_flying = true
	return self

func _on_area_entered(area: Area2D) -> void:
	if is_flying && area is Cell && distance_flew > 30:
		is_flying = false
		distance_flew = 0
#		print("area entered, cell energy: " + str(area.energy))
		call_deferred("add_to_cell", area)

func add_to_cell(cell: Cell) -> void:
	get_parent().remove_child(self)
	cell.add_block(self)

func set_player(player_id: int):
	
	#print("============================================================================")
	#print("current player: " + str(player))
	#print("setting player " + str(player_id) + ", sprite = " + str(!(sprite == null)))
	
	var recent_player: int = player
	
	player = player_id
	
	if sprite == null:
		call_deferred("set_player", player_id)
		return
	
	game.players[recent_player].blocks_count -= 1
	
	#print("-------------------------------------------------------")
	#
	#print("subtracting block from player " + str(recent_player) + ", now he has " + str(game.players[recent_player].blocks_count))
	
	game.players[player_id].blocks_count += 1
	
	#print("adding block to player " + str(player_id) + ", now he has " + str(game.players[player_id].blocks_count))
	
	sprite.self_modulate = game.players[player_id].color
