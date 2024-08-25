extends HBoxContainer

var list_players
var _index_selected
var _style_box_highlight #TODO DYNAMIC
var _style_box_not_highlight #TODO DYNAMIC

func _ready():
	#Setting color
	_style_box_highlight = StyleBoxFlat.new()
	_style_box_highlight.bg_color = Color(0.2, 0.6, 0.8) 
	_style_box_not_highlight = StyleBoxFlat.new()
	_style_box_not_highlight.bg_color = Color(0.3, 0.3, 0.3) 
	
	list_players = get_parent().get_parent()._list_players
	_index_selected = get_parent().get_parent()._currently_selected_player
	var i = 0
	for player in list_players:
		var player_row = Button.new()
		player_row.size_flags_horizontal = Control.SIZE_EXPAND
		#player_row.alignment = BoxContainer.ALIGNMENT_CENTER
		player_row.set_text(player.name)
		player_row.pressed.connect(_change_player.bind(i))
		if i == _index_selected:
			player_row.add_theme_stylebox_override("normal", _style_box_highlight)
		else:
			player_row.add_theme_stylebox_override("normal", _style_box_not_highlight)
		add_child(player_row)
		i = i + 1

	show()

func _change_player(new_index): # Set the background color
	get_children()[_index_selected].add_theme_stylebox_override("normal", _style_box_not_highlight)
	_index_selected = new_index
	get_children()[_index_selected].add_theme_stylebox_override("normal", _style_box_highlight)
