extends Area2D
class_name Cell

const BlockScene = preload('res://Game/Block/block.tscn')
#const BlockContainer = preload('res://Game/Cell/BlockContainer/block_container.tscn')
#const GameManager = preload('res://Game/Main/game.gd')

var is_blocked : bool = false
var player : int = 0
var energy : int = 0
var max_energy : int = 4

@onready var game: GameManager = get_tree().current_scene
@onready var cycle_node : Sprite2D = get_node("Cycle")
@onready var flying_blocks_container : Node2D = $"../../FlyingBlocksContainer"
@onready var grating : Sprite2D = $Grating
@onready var block_container_nodes : Array [BlockContainer] = [
	$BlockContainers/BlockContainer0,
	$BlockContainers/BlockContainer1,
	$BlockContainers/BlockContainer2,
	$BlockContainers/BlockContainer3,
]


func set_block_containers(containers_to_show: Array[bool]) -> void:
	
	max_energy = 0
		
	for i in range(containers_to_show.size() - 1, -1, -1):
		if containers_to_show[i] == false:
			var container: BlockContainer = block_container_nodes[i]
			container.queue_free()
			block_container_nodes.pop_at(i)
		else:
			max_energy += 1

func _input_event(_viewport, event, _shape_idx) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click() -> void:
	
	if is_blocked:
		return
	if game.state != game.State.PLAYER_MOVE and !game.game_ended:
		return
	if energy > 0 and game.curr_player != player:
		return
	
	game.cell_clicked()
	
	var block: Block = BlockScene.instantiate()
	block.set_player(game.curr_player)
	add_block(block)

func add_block(block: Block) -> void:
	
	block_container_nodes[energy].add_child(block)
	block.position = Vector2()
	
	energy+=1
	
	if energy == 1:
		game.players[block.player].cells_occupied += 1
	elif player != block.player:
		game.players[block.player].cells_occupied += 1
		game.players[player].cells_occupied -= 1
	
	if energy == 1:
		cycle_node.show()
	
	set_player(block.player)
	
	if energy >= max_energy:
		#print("----------------------")
		#print("en    " + str(energy))
		#print("max   " + str(max_energy))
		explode()
	
func explode() -> void:
	
	game.players[player].cells_occupied -= 1
	
	cycle_node.hide()
	
	energy -= max_energy
	for container in block_container_nodes:
		var block: Block = container.get_block()
		
		if block == null:
			print_debug("error")
		
		block.throw(container.relative_raw_position)
		container.remove_child(block)
		block.position = container.global_position
		flying_blocks_container.add_child(block)
	
func set_player(player_id: int) -> void:
	player = player_id
	
	cycle_node.self_modulate = game.players[player_id].color
	
	for i in range(0, energy):
		var container: BlockContainer = block_container_nodes[i]
		var block: Block = container.get_block()
		block.set_player(player_id)

func block_cell() -> void:
	is_blocked = true
	grating.show()

func to_dict() -> Dictionary:
	return {
		"is_blocked": is_blocked,
		"player": player,
		"energy": energy
	}

func load_data_from_dict(dict: Dictionary) -> void:
	
	clear_block_containers()
	
	cycle_node.hide()
	
	energy = 0
	
	#print("----------------------------------------------------")
	#print("loading " + str(dict))
	#print(game.players)
	
	for i in range(dict.energy):
		
		#print("i: " + str(i) + ", players: " + str(game.players))
		
		var block: Block = BlockScene.instantiate()
		block.set_player(dict.player)
		
		add_block(block)
	
	is_blocked = dict.is_blocked
	set_player(dict.player)
	#energy = dict.energy
	
	#print(game.players)

func clear_block_containers() -> void:
	for container in block_container_nodes:
		for child in container.get_children():
			child.queue_free()
