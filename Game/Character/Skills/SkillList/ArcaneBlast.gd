extends Node

var _damage_container
var _overseer
var _hero
var _map_manager







var _skill_name = "Arcane Blast"
var _skill_type = "AoE"
var _skill_description = "Deals 30 magic damage to all targets in a 1 tile radius."
var _skill_cost = 3
var _skill_cooldown = 2

var _current_cooldown = 0
var _usable = true
var _ready_to_confirm = true
var _calculate_skillable_tiles = true

var _skillable_tiles = []


func initialize(overseer, hero):
	_damage_container = preload("res://Party/Utils/DamageContainer.gd").new()
	_damage_container.initialize(0,20,0)
	_hero = hero
	_map_manager = overseer._map_manager



# Utility

func is_skill_confirmable():
	if _usable and _ready_to_confirm:
		return true
	return false

func on_turn_start():
	_current_cooldown -= 1
	if _current_cooldown < 0:
		_usable = true
	clear_meta_info()

func on_move():
	clear_meta_info()


func clear_meta_info():
	_calculate_skillable_tiles = true
	_skillable_tiles.clear()



# Target Selection

func on_skill_select(): # when you confirm the skill in the skill panel
	if _calculate_skillable_tiles:
		_skillable_tiles = _map_manager.get_tiles_in_range( \
		_hero._coordinates, 1)
		
		_skillable_tiles.remove( \
		_skillable_tiles.find(\
		_map_manager.get_tile_with_coordinates(_hero._coordinates)))
		
		_calculate_skillable_tiles = false
	
	if _skillable_tiles.size() == 0:
			_usable = false
			_ready_to_confirm = false
	else:
		_ready_to_confirm = true
	
	_map_manager.highlight_tiles_confirm(_skillable_tiles)

func on_skill_deselect():
	_ready_to_confirm = false
	_map_manager.remove_highlight_from_select_tiles()
	_map_manager.remove_highlight_from_confirm_tiles()



func confirm_skill():
	for tile in _skillable_tiles:
		tile.skill_tile(self)
	_map_manager.remove_highlight_from_confirm_tiles()
	_usable = false
	_ready_to_confirm = false
	_current_cooldown = _skill_cooldown


func apply_skill(target):
	print("HP Before: ", target._attributes._current_health)
	target._attributes.receive_attack(_damage_container)
	print("HP After: ", target._attributes._current_health)



















