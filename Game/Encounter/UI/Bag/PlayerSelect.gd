extends VBoxContainer


var list_players = [
	{ "name": "Player1"}, 
	{ "name": "Player2"},
]

func _ready():
	for player in list_players:
		var player_row = HBoxContainer.new()

		var player_name = Label.new()
		player_name.text = str(player.name)
		player_row.add_child(player_name)

		add_child(player_row)

	show()
