#class_name GameState
#
#var curr_player: int
#var curr_turn: int
#var players: Array[Player]
#var cells: Dictionary
#
#func _init() -> void:
#
#func get_curr_game_state_as_dict():
	#
	#return {
		#"curr_player": curr_player,
		#"curr_turn": curr_turn,
		#"players": players_array_into_dictionary_array(players),
		#"cells": cells_array_into_dictionary_array(cells)
	#}
#
#func cells_array_into_dictionary_array(cells_arr: Array[Cell]) -> Array[Dictionary]:
	#var ret_arr: Array[Dictionary] = []
	#
	#for cell in cells_arr:
		#ret_arr.push_back(cell.to_dict())
	#
	#return ret_arr
