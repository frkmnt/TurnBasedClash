extends Node

var _list_type_slots
var _index_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	_list_type_slots = get_parent().get_parent()._list_type_slots
	_index_selected = get_parent().get_parent()._currently_selected_slot 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_index(new_index):
	var _index_selected = new_index
	for gear in _list_type_slots[new_index].items:
		var equipment_row = Button.new()
		equipment_row.size_flags_horizontal = Control.SIZE_EXPAND
		equipment_row.alignment = BoxContainer.ALIGNMENT_CENTER
		#equipment_row.pressed.connect(_change_equipment.bind(i))
		var gear_name = gear.name
		equipment_row.set_text(gear.name)
		add_child(equipment_row)