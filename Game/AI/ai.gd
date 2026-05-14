class_name AI

func your_turn(game_state: Dictionary, player_id: int) -> int:
	
	for i: int in range(game_state.cells.size()):
		
		var cell: Dictionary = game_state.cells[i]
		
		if cell.player == player_id or cell.energy == 0:
			return i
	
	return 0
