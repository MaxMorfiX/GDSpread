extends AI
class_name Random_AI

func your_turn(game_state: Dictionary, player_id: int) -> int:
	
	while(true):
		
		var i = randi_range(0, game_state.cells.size()-1)
		
		var cell: Dictionary = game_state.cells[i]
		
		if cell.player == player_id or cell.energy == 0:
			return i
	
	return 0
