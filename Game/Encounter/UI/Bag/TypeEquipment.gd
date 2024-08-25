extends HBoxContainer

var _list_type_slots
var _index_selected
var _style_box_highlight #TODO DYNAMIC
var _style_box_not_highlight #TODO DYNAMIC

func _ready():
	#Setting color
	_style_box_highlight = StyleBoxFlat.new()
	_style_box_highlight.bg_color = Color(0.2, 0.6, 0.8) 
	_style_box_not_highlight = StyleBoxFlat.new()
	_style_box_not_highlight.bg_color = Color(0.3, 0.3, 0.3) 
	
	_list_type_slots = get_parent().get_parent()._list_type_slots
	_index_selected = get_parent().get_parent()._currently_selected_slot 
	var i = 0
	for equipment in _list_type_slots:
		var equipment_row = Button.new()
		equipment_row.size_flags_horizontal = Control.SIZE_EXPAND
		equipment_row.alignment = BoxContainer.ALIGNMENT_CENTER
		equipment_row.pressed.connect(_change_equipment.bind(i))
		equipment_row.set_text(equipment.name)
		if i == _index_selected:
			equipment_row.add_theme_stylebox_override("normal", _style_box_highlight)
		else:
			equipment_row.add_theme_stylebox_override("normal", _style_box_not_highlight)
		add_child(equipment_row)
		i = i + 1

	show()

func _change_equipment(new_index): # Set the background color
	get_children()[_index_selected].add_theme_stylebox_override("normal", _style_box_not_highlight)
	_index_selected = new_index
	get_children()[_index_selected].add_theme_stylebox_override("normal", _style_box_highlight)
