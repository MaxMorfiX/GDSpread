extends CenterContainer
class_name Tutorial

var tutorial_phrases: Array[String] = [
	"In your turn, you can click on any of the cells (the gray ones) to fill them with blocks of your color. However, you cannot click on cells that are already occupied by the other player.",
	"You can place multiple blocks in a single cell (the number depends on the shape of the cell). When you completely fill a cell with blocks, it will explode, spreading blocks to neighboring cells. If any of the neighboring cells are occupied by the other player, their blocks will be converted into your blocks.",
	"If a player loses all of their blocks, they lose the game. The player wins when only blocks of their own color are left on the board."
]

var was_first_cell_exploded: bool = false
var was_first_cell_exploded_triggered = false

@onready var hint_label: RichTextLabel = $BackgroundColorRect/HintLabel

var curr_phrase_id: int = 0

func _ready() -> void:
	
	print("gamemode: " + str(GameSettings.gamemode))
	
	if GameSettings.gamemode != GameSettings.GAMEMODE.TUTORIAL:
		hide()
	#else:
		#get_node("../LeaderboardCenterContainer").hide()
	
	hint_label.text = tutorial_phrases[curr_phrase_id] + "\n"

func first_round_was_played() -> void:
	if curr_phrase_id == 0:
		next_phrase()

func next_phrase() -> void:
	curr_phrase_id += 1
	hint_label.text = tutorial_phrases[curr_phrase_id] + "\n"

func cell_exploded() -> void:
	was_first_cell_exploded = true

func next_player_started() -> void:
	#print("hiiii")
	if was_first_cell_exploded and !was_first_cell_exploded_triggered and curr_phrase_id == 1:
		next_phrase()
