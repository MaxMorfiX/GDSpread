extends Area2D
class_name Block

var Cell = preload('res://Game/Cell/cell.tscn')

const speed = 300

enum States {IN_THE_CELL, FLYING}
var state : int = States.IN_THE_CELL

var velocity: Vector2
var distance_flew = 0

func _process(delta: float) -> void:
	match state:
		States.IN_THE_CELL:
			process_in_the_cell(delta)
		States.FLYING:
			process_flying(delta)
			

func process_in_the_cell(_delta: float) -> void:
	pass

func process_flying(delta: float) -> void:
	
	var offset := velocity*delta
	
	position += offset
	distance_flew += offset.length()

func throw(direction: Vector2) -> Block:
	velocity = direction*speed
	state = States.FLYING
	return self
	



func _on_area_entered(area: Area2D) -> void:
	if state == States.FLYING && area is Cell && distance_flew > 30:
		state = States.IN_THE_CELL
		distance_flew = 0
#		print("area entered, cell energy: " + str(area.energy))
		call_deferred("add_to_cell", area)

func add_to_cell(cell: Cell) -> void:
	get_parent().remove_child(self)
	cell.add_block(self)
