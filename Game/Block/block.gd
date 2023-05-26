extends Area2D
class_name Block

var Cell = preload('res://Game/Cell/cell.tscn')

const speed = 300

@onready var sprite: Sprite2D = get_node("Sprite2D")

var is_flying : bool = false

var player : int = 0
var velocity: Vector2
var distance_flew = 0

func _physics_process(delta: float) -> void:
	if is_flying:
		var offset := velocity*delta
		
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
	
	player = player_id
	
	if sprite == null:
		call_deferred("set_player", player_id)
		return
	sprite.self_modulate = get_tree().current_scene.players[player_id].color
