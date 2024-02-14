class_name Player

var color: Color = Color()
var is_active: bool = true

var cells_occupied: int = 0
var blocks_count: int = 0

func _init(set_color: Color) -> void:
	color = set_color

func _to_string() -> String:
	return "{cells: " + str(cells_occupied) + ", blocks: " + str(blocks_count) + "}"

func to_dict() -> Dictionary:
	return {
		"color": color.to_html(),
		"is_active": is_active,
		"cells_occupied": cells_occupied,
		"blocks_count": blocks_count
	}

static func from_dict(dictionary: Dictionary) -> Player:
	var player: Player = Player.new(dictionary.color)
	player.color = dictionary.color
	player.cells_occupied = dictionary.cells_occupied
	player.blocks_count = dictionary.blocks_count
	
	#print(dictionary)
	
	return player
