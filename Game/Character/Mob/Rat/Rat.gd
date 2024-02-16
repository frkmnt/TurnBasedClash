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

#=== Data Components ===#
var _attributes
var _stats
var _modifiers
var _skills

#=== Metadata ===#
# The index of the current target, reset on_turn_end. A target is selected if _cur_target_idx >= 0.
var _cur_target_idx = -1 




#=== Bootstrap ===#

func _ready():
	_animator = $Animator
	_character_manager = get_parent()
	_map_manager =_character_manager._map_manager

func initialize(mob_data):
	_attributes = mob_data.attributes
	_stats = mob_data.stats
	_modifiers = mob_data.modifiers
	_skills = mob_data.skills




#=== Turn Management ===#

# Handles the turn start logic.
func on_turn_start():
	_stats.on_turn_start()
	_skills.on_turn_start()
	turn_start_behaviour()

# Calculates and applies the turn start behaviour.
func turn_start_behaviour():
	var nearest_heroes_data = _character_manager.find_nearest_heroes_to_current_character() # [(hero_id, coords)]
	_cur_target_idx = nearest_heroes_data[0][0]
	var target_coords = _map_manager._character_coords.get(_cur_target_idx)
#	print("targ ", target, ", at coords ", target_coords)
	_character_manager.move_current_enemy_along_path(target_coords, _stats._speed)


# Handles the on move logic.
func on_move(path, speed_cost):
	_stats._cur_speed -= speed_cost
	_animator.play_data_anim("move", path)

# Handles the on finished logic.
func on_finished_moving():
	if _cur_target_idx >= 0:
		var rat_bite = _skills.get_skill("rat_bite")
		while is_skill_usable(rat_bite):
			var target = _character_manager.get_character_by_id(_cur_target_idx)
			rat_bite.apply_skill(target)
	on_turn_end()


# Handles the on turn end logic.
func on_turn_end():
	_cur_target_idx = -1
	SignalManager.emit_signal("_on_pass_turn")





#=== Utils ===#

func is_skill_usable(skill):
	var is_usable = true
	if not skill.is_usable() \
	or _stats._cur_speed < skill._cost:
		is_usable = false
	return is_usable


