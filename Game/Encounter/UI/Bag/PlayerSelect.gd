extends HBoxContainer

var list_players

func _ready():
	list_players = get_parent().get_parent()._list_players
	var i = 0
	for player in list_players:
		var player_row = Button.new()
		player_row.size_flags_horizontal = Control.SIZE_EXPAND
		#player_row.alignment = BoxContainer.ALIGNMENT_CENTER
		player_row.set_text(player.name)
		player_row.pressed.connect(_change_player.bind(i))
		add_child(player_row)
		i = i + 1

	show()

func _change_player(number_player):
	print("number_player")
	print(number_player)
	#get_parent().get_parent()._change_player(1)
