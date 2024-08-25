extends Panel

#==== References ====#
var _parent_menu
var _players
var _inventory

#==== Components ====#
var _item_selected
var _item_current
var _item_list
var _switch_gear_button
var _player_select
var _type_equipment


#==== Variables ====#
var _currently_selected_slot = 0 #headset, weapon, etc
var _currently_selected_gear #type of headset
var _currently_equiped_gear #type of headset equipped
var _list_type_slots = [ #TODO DYNAMIC
		{ "name": "Headset", "items": [] },
		{ "name": "Armor", "items": [] },
		{ "name": "Weapon", "items": [] },
		{ "name": "Ring", "items": [] },
	]
var _list_players = [ #TODO DYNAMIC
		{ "name": "Player1"},
		{ "name": "Player2"},
		{ "name": "Player3"},
		{ "name": "Player4"}
	]
var _currently_selected_player = 0

#==== Buttons ====#
var _close_bag_button

#==== Bootstrap ====#

func initialize(parent_menu):
	_parent_menu = parent_menu
	_item_selected = $Menu/ItemSelected
	_item_current = $Menu/ItemCurrent
	_item_list = $Menu/ItemList
	_switch_gear_button = $Menu/SwitchGear
	_player_select = $PlayerSelect
	_type_equipment = $TypeEquipment
	_close_bag_button = $CloseBagButton
	
	_currently_selected_player = 0
	_currently_selected_slot = 0
	
	var current_button
	for index in range(0, _item_list.get_child_count()): # initialize buttons
		current_button = _item_list.get_child(index)
		current_button.connect("button_down", self, "on_slot_pressed", [index])


func _ready(): #TODO Dynamic
	_currently_selected_player = 0
	_currently_selected_slot = 0


#==== UI Interaction ====#

# Make the panel visible
func on_close_panel():
	visible = false


# Make the panel invisible
func on_open_panel():
	visible = true

#func on_switch_gear_button_down():
	#pass # Replace with function body.


func _on_close_bag_button_button_up():
	visible = !visible
