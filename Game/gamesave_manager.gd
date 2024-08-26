extends Node

var default_filepath: String = "user://gamesave.json"

func save_dict(dict: Dictionary, filepath: String = default_filepath) -> void:
	
	var json_string: String = JSON.stringify(dict)
	
	var save_game: FileAccess = FileAccess.open(filepath, FileAccess.WRITE)
	save_game.store_line(json_string)

func load_dict(filepath: String = default_filepath) -> Dictionary:
	
	if not FileAccess.file_exists(filepath):
		print("Trying to load a missing savefile! Returning empty dictionary")
		return {}
	
	var save_game = FileAccess.open(filepath, FileAccess.READ)
	var json_string = save_game.get_as_text()
	
	var json = JSON.new()
	var error = json.parse(json_string)
	
	if error == OK:
		return json.data
	
	print("Couldn't parse savedata json while loading gamesave! Returning empty dictionary")
	
	return {}

func _ready() -> void:
	
	if FileAccess.file_exists(default_filepath):
		return
	
	save_dict({
		"game_state": {},
		"game_settings": GameSettings.to_dict()
	})

func is_there_unfinished_game() -> bool:
	var dict: Dictionary = load_dict()
	return dict.game_state != {}
