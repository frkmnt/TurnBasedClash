extends HBoxContainer


var list_players = [
	{ "name": "Player1"}, 
	{ "name": "Player2"},
]

func _ready():
	for player in list_players:
		var player_row = Button.new()
		player_row.size_flags_horizontal = Control.SIZE_EXPAND
		player_row.alignment = BoxContainer.ALIGNMENT_CENTER
		
		var player_name = Label.new()
		player_name.text = str(player.name)
		player_row.add_child(player_name)
		add_child(player_row)

	show()
