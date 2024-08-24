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
var _currently_selected_slot
var _currently_selected_gear
var _currently_selected_player

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
	
	_currently_selected_slot = -1
	
	var current_button
	for index in range(0, _item_list.get_child_count()): # initialize buttons
		current_button = _item_list.get_child(index)
		current_button.connect("button_down", self, "on_slot_pressed", [index])


func _ready():
	var player_group_objects = get_tree().get_nodes_in_group("Player") # TODO refactor
#	_currently_selected_player = player_group_objects[0]





#==== UI ====#

#func add_weapon_to_slot(weapon):
#	var weapon_slot = _equipment_panel.get_child(3)
#	weapon_slot.icon = weapon._sprite
#
#func add_item_to_slot(item, slot_index):
#	var slot = _items_panel.get_child(slot_index)
#	slot.icon = item._sprite
#	var slot_amount_label = slot.get_child(0)
#	slot_amount_label.text = str (1)
#
#
#func remove_item_image_from_slot(slot_index):
#	_use_button.visible = false
#	_info_label.text = ""
#	var slot = _items_panel.get_child(slot_index)
#	slot.icon = null
#	var slot_amount_label = slot.get_child(0)
#	slot_amount_label.text = str (0)
#
#
#func update_item_amount_in_label(quantity, slot_index):
#	var slot = _items_panel.get_child(slot_index)
#	var slot_amount_label = slot.get_child(0)
#	slot_amount_label.text = str (quantity)
#
#func decrement_item_amount_in_slot(quantity, slot_index):
#	var slot = _items_panel.get_child(slot_index)
#	var slot_amount_label = slot.get_child(0)
#	slot_amount_label.text = str (quantity)
#
#
#
#
#func on_slot_pressed(slot_id): 
#	var slot_item = _inventory._item_list[slot_id][0]
#	if not slot_item == null:
#		_currently_selected_slot = slot_id
#		var item_type = slot_item._object_data._type
#		if item_type == "weapon":
#			_use_button.visible = true
#			_use_button.text = "Equip Weapon"
#			_info_label.text = generate_weapon_label(slot_item)
#		elif item_type != "money":
#			_use_button.visible = true
#			_use_button.text = "Use Item"
#			_info_label.text = generate_item_label(slot_item)
#		else: # money
#			_info_label.text = generate_item_label(slot_item)
#
#	else:
#		_info_label.text = ""
#
#
#func on_equipped_weapon_slot_press():
#	_info_label.text = generate_weapon_label(_inventory._weapon)
#	_use_button.visible = false
#
#
#
#func use_item_on_slot():
#	var slot_item = _inventory._item_list[_currently_selected_slot][0]
#	_inventory.remove_item_from_slot(_currently_selected_slot)
#	slot_item.use_item(_player)
#
#
#
#func _on_inventory_panel_hide():
#	_info_label.text = ""
#	_currently_selected_slot = -1
#	_use_button.visible = false
#
#
#
#
#
#
#
#func toggle_visibility():
#	if self.visible == true:
#		self.visible = false
#	else:
#		self.visible = true
#
#
#func on_disable_inventory_button_click():
#	_parent_menu.disable_inventory()
#
#
#
#
#
#
##==== Label Generation ====#
#
#func generate_item_label(item):
#	var item_object_data = item._object_data
#	return \
#		item_object_data._name + "\n" + \
#		item_object_data._description + "\n\n" + \
#		"Value: " + String(item_object_data._value)
#
#func generate_weapon_label(weapon):
#	var weapon_object_data = weapon._object_data
#	var weapon_data = weapon._weapon_data
#	return "teste"#\
#		weapon_object_data._name + "\n" + \
#		weapon_object_data._description + "\n\n" + \
#		"Average Damage: " + String(weapon_data._average_attack_values) + "\n" + \
#		"Damage Modifier: " + String(stepify(weapon_data._damage_modifier, 0.1)) + "\n" + \
#		"Knockback Modifier: " + String(stepify(weapon_data._knockback_modifier, 0.1)) + "\n" + \
#		"Critical Hit Modifier: " + String(stepify(weapon_data._crit_modifier, 0.1)) + "\n" + \
#		"Critical Hit Chance: " + String(stepify(weapon_data._crit_chance, 0.1)) + "%"




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
