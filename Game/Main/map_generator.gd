extends Node2D

var Cell = preload('res://Game/Cell/cell.tscn')

var step_size = 360*1.5

func generate_map(size: int) -> Array:
	
	var cells = []
	
	for raw_x in range(0, size):
		for raw_y in range(0, size):
			
			var cell = generate_cell(raw_x, raw_y)
			cells.append(cell)
			
			var bottom = raw_y != size-1;
			var top = raw_y != 0;
			var left = raw_x != 0;
			var right = raw_x != size-1;
			
			cell.set_block_containers([top, left, right, bottom])
			
	var camera : Camera2D = get_parent().get_node("Camera2D")
	
	var camera_pos = Vector2((size - 1)*step_size/2, (size - 1)*step_size/2)
	camera.position = camera_pos
	var camera_zoom = 6e2/(size*step_size)
	print(camera_zoom)
	camera.zoom = Vector2(camera_zoom, camera_zoom)
	
	return cells

func generate_cell(raw_x: int, raw_y: int) -> Cell:
	var cell = Cell.instantiate()
	
	var pos = Vector2(raw_x, raw_y)
	pos *= step_size
	
	cell.position = pos
	
	add_child(cell)
	
	return cell
