class_name Player

var color: Color = Color()
var is_active: bool = true

var cells_occupied: int = 0
var blocks_count: int = 0

var is_ai: bool = false
var ai: AI

func _init(set_color: Color, player_ai: AI = null) -> void:
	color = set_color
	if player_ai != null:
		is_ai = true
		ai = player_ai

func _to_string() -> String:
	return "{cells: " + str(cells_occupied) + ", blocks: " + str(blocks_count) + "}"

func to_dict() -> Dictionary:
	return {
		"color": color.to_html(),
		"is_active": is_active,
		"cells_occupied": cells_occupied,
		"blocks_count": blocks_count,
		"is_ai": is_ai
	}

static func from_dict(dict: Dictionary) -> Player:
	var player: Player = Player.new(dict.color)
	player.color = dict.color
	player.cells_occupied = dict.cells_occupied
	player.blocks_count = dict.blocks_count
	player.is_ai = dict.is_ai
	
	#print(dict)
	
	return player
