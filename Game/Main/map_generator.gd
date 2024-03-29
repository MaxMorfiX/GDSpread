extends Node2D

const CellScene = preload('res://Game/Cell/cell.tscn')

var step_size: float = 360*1.5

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func generate_map() -> Array[Cell]:
	
	var size: int = GameSettings.map_size
	
	var cells : Array[Cell] = []
	
	for raw_x in range(0, size):
		for raw_y in range(0, size):
			
			var cell: Cell = generate_cell(raw_x, raw_y)
			cells.append(cell)
			
			var bottom: bool = raw_y != size-1;
			var top: bool = raw_y != 0;
			var left: bool = raw_x != 0;
			var right: bool = raw_x != size-1;
			
			cell.set_block_containers([top, left, right, bottom])
			
	var camera : Camera2D = get_parent().get_node("Camera2D")
	
	var camera_pos: Vector2 = Vector2((size - 1)*step_size/2, (size - 1)*step_size/2)
	camera.position = camera_pos
	var camera_zoom: float = 6e2/(size*step_size)
	#print(camera_zoom)
	camera.zoom = Vector2(camera_zoom, camera_zoom)
	
	if GameSettings.gamemode == GameSettings.GAMEMODE.BLOCKED_CELLS:
		#checking if all cells are blocked

		for cell in cells:
			if !cell.is_blocked:
				return cells
			
		for child in get_children():
			child.queue_free()
		
		return generate_map()
	
	return cells

func generate_cell(raw_x: int, raw_y: int) -> Cell:
	
	var cell: Cell = CellScene.instantiate()
	
	var pos: Vector2 = Vector2(raw_x, raw_y)
	pos *= step_size
	
	cell.position = pos
	
	add_child(cell)
	
	if GameSettings.gamemode == GameSettings.GAMEMODE.BLOCKED_CELLS:
		var block: float = rng.randf()
		
		if block < GameSettings.blocked_cell_chance: cell.block_cell()
	
	return cell
