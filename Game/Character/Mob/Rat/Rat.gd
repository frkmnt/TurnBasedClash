extends Node2D

#=== About ===#
# The weakest mob. They attack a random adjacent hero, or move to the closest hero if no heroes are nearby.
# They move to a random hero in case of a distance tie.


#=== References ===#
var _character_manager
var _map_manager

#=== Components ===#
var _animator
#var _sprite #TODO integrate with the animator

#=== Base Enemy Stats ===#
var _name = "Rat"
var _description = "A fairly common species of rodent. Dull-witted and frail, they pose virtually no threat alone, but may become a nuinsance in large numbers."

var _attributes
var _stats
var _basic_attack



#=== Bootstrap ===#

func _ready():
	_animator = $Animator
	_character_manager = get_parent()
	_map_manager =_character_manager._map_manager

func initialize(mob_data):
	_attributes = mob_data.attributes
	_stats = mob_data.stats





#=== Turn Management ===#

func on_turn_start():
	print("wow")
	_stats.on_turn_start()
	turn_start_behaviour()

func turn_start_behaviour():
	var nearest_heroes = _character_manager.find_nearest_heroes()
	var target = nearest_heroes[0]
	var target_coords = _map_manager._character_coords.get(_character_manager._cur_character_idx)
	print("targ ", target, ", at coords ", target_coords)
	_character_manager.move_current_enemy_along_path(target_coords, _stats._speed)



func on_move(path):
	pass



#=== Animations ===#





#=== Utils ===#

func is_hero_in_range(mob_id):
	pass
#	_encounter_manager._map_manager.get_entities_in_range()

func attack_random_hero_in_range():
	pass


func move_to_random_hero():
	pass

