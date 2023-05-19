extends Area2D
class_name Cell
var Block = preload('res://Game/Block/block.tscn')



var energy = 0
var max_energy = 4



var block_container_nodes: Array
var cycle_node: Sprite2D

func _ready() -> void:
	block_container_nodes = [
		$BlockContainers/BlockContainer0,
		$BlockContainers/BlockContainer1,
		$BlockContainers/BlockContainer2,
		$BlockContainers/BlockContainer3,
	]
	
	cycle_node = get_node("Cycle")


func set_block_containers(containers_to_show: Array) -> void:
	
	max_energy = 0
		
	for i in range(containers_to_show.size() - 1, -1, -1):
		if containers_to_show[i] == false:
			var container = block_container_nodes[i]
			container.queue_free()
			block_container_nodes.pop_at(i)
		else:
			max_energy += 1


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click() -> void:
	add_block()

func add_block() -> void:
	
	energy+=1
	
	if energy == 1:
		cycle_node.show()
	
	var block = Block.instantiate()
	
	block_container_nodes[energy - 1].add_child(block)
	
	if energy >= max_energy:
		explode()
	
func explode() -> void:
	
	cycle_node.hide()
	
	energy -= max_energy
	for container in block_container_nodes:
		container.get_node("block").queue_free()
	
