extends Node

var _map_manager
var _hero
var _damage_container

var _skill_name = "Fireball"
var _skill_type = "Target"
var _skill_description = "Deals 60 magic damage to the target."
var _skill_cost = 3
var _skill_cooldown = 3

var _current_cooldown = 0
var _usable = false
var _ready_to_confirm = false
var _calculate_skillable_tiles = true

var _skillable_tiles = []
var _target


func initialize(overseer, hero):
	_damage_container = preload("res://Party/Utils/DamageContainer.gd").new()
	_damage_container.initialize(0,60,0)
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
	_target = null



# Target Selection

func on_skill_select(): # when you confirm the skill in the skill panel
	if _calculate_skillable_tiles:
		_skillable_tiles = _map_manager.get_attackable_tiles_in_range( \
		_hero._coordinates, 2)
		
		_skillable_tiles.remove( \
		_skillable_tiles.find(\
		_map_manager.get_tile_with_coordinates(_hero._coordinates)))
		
		_calculate_skillable_tiles = false
	
	if _skillable_tiles.size() == 0:
			_usable = false
	else:
			_usable = true
	_map_manager.highlight_tiles_select(_skillable_tiles)

func on_skill_deselect():
	_ready_to_confirm = false
	_target = null
	_map_manager.remove_highlight_from_select_tiles()
	_map_manager.remove_highlight_from_confirm_tiles()



func on_tile_click(tile):
	if _usable:
		if _target == null:
			on_target_select(tile)
		else:
			on_target_confirmed(tile)


func on_target_select(tile): # highlight targets
	if tile in _skillable_tiles:
		_map_manager.remove_highlight_from_select_tiles()
		_target = tile
		_map_manager.highlight_tile_confirm(tile)
		_ready_to_confirm = true


func on_target_confirmed(tile):
	if tile != _target:
		_map_manager.remove_highlight_from_confirm_tiles()
		_target = null
		_map_manager.highlight_tiles_select(_skillable_tiles)
		_ready_to_confirm = false


func confirm_skill():
	_target.skill_tile(self)
	_map_manager.remove_highlight_from_confirm_tiles()
	_usable = false
	_current_cooldown = _skill_cooldown


func apply_skill(target):
	print("HP Before: ", target._attributes._current_health)
	target._attributes.receive_attack(_damage_container)
	print("HP After: ", target._attributes._current_health)


















