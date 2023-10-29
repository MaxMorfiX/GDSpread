extends Area2D
class_name Cell

const Block = preload('res://Game/Block/block.tscn')
const BlockContainer = preload('res://Game/Cell/BlockContainer/block_container.tscn')


var is_blocked : bool = false
var player : int = 0
var energy = 0
var max_energy = 4

@onready var game = get_tree().current_scene
@onready var cycle_node : Sprite2D = get_node("Cycle")
@onready var flying_blocks_container : Node2D = $"../../FlyingBlocksContainer"
@onready var grating : Sprite2D = $Grating
@onready var block_container_nodes : Array [Node] = [
	$BlockContainers/BlockContainer0,
	$BlockContainers/BlockContainer1,
	$BlockContainers/BlockContainer2,
	$BlockContainers/BlockContainer3,
]


func set_block_containers(containers_to_show: Array[bool]) -> void:
	
	max_energy = 0
		
	for i in range(containers_to_show.size() - 1, -1, -1):
		if containers_to_show[i] == false:
			var container = block_container_nodes[i]
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
	
	var block: Block = Block.instantiate()
	block.set_player(game.curr_player)
	add_block(block)

func add_block(block: Block) -> void:
	
	block_container_nodes[energy].add_child(block)
	block.position = Vector2()
	
	set_player(block.player)
	
	energy+=1
	
	if energy == 1:
		cycle_node.show()
	
	if energy >= max_energy:
		explode()
	
func explode() -> void:
	
	cycle_node.hide()
	
	energy -= max_energy
	for container in block_container_nodes:
		var block = container.get_block()
		
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
