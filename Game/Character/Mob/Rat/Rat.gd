extends Node2D

#=== About ===#
# A weak mob. They attack a random adjacent hero, or move to the closest hero if no heroes are nearby.
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
# The index of the current target, reset on_turn_end. A target is selected if _cur_target_id >= 0.
var _cur_target_id = -1 
var _cur_target_coords = Vector2(-1,-1)
var _cur_target_move_dist = 0




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




#=== Trigger Logic ===#

# Handles the turn start logic, including calculating the behaviour and queueing animations.
func on_turn_start():
	_stats.on_turn_start()
	_skills.on_turn_start()
	find_nearest_target()
	standard_rat_behaviour()


# Calculates and applies the turn start behaviour.
func apply_turn_start():
	_cur_target_id = -1
	_animator.play_anim_queue("_on_pass_turn")


# Handles the on move logic.
func on_move(path, speed_cost):
	#TODO Modifiers
	_stats._cur_speed -= speed_cost
	_cur_target_move_dist -= speed_cost


# Handles the on finished logic.
func on_finished_moving():
	#TODO
	pass


# Handles the on turn end logic.
func on_turn_end():
	#TODO
	pass




#=== Character Specific Logic ===#

func standard_rat_behaviour():
	#TODO check if there is a target
	var rat_bite = _skills.get_skill("rat_bite")
	if is_target_in_range(rat_bite):
		attempt_attack_on_target(rat_bite)
	elif can_move():
		var path_info = _character_manager.get_current_enemy_path_to_coords(_cur_target_coords, _stats._cur_speed) #[path, speed_cost]
		var cur_coords = path_info[0]
		var path = path_info[1]
		var speed_cost = path_info[2]
		_animator.queue_data_anim("signal", ["_remove_highlight_from_tiles", [cur_coords]])
		on_move(path, speed_cost)
		_animator.queue_data_anim("log", "The Rat moves.")
		_animator.queue_data_anim("move", path)
		_animator.queue_data_anim("signal", ["_highlight_current_character", null])
		standard_rat_behaviour()


func attempt_attack_on_target(skill):
	if _character_manager.is_character_in_range_of_current_character(_cur_target_id, skill._range):
		var target = _character_manager.get_character_by_id(_cur_target_id)
		var log = ""
		while is_skill_usable(skill):
			_stats._cur_speed -= skill._cost
			log = skill.apply_skill(target)
			_animator.queue_simple_anim(skill._id, false)
			_animator.queue_data_anim("log", log)




#=== Utils ===#

func find_nearest_target():
	var nearest_heroes_data = _character_manager.find_nearest_heroes_to_current_enemy() # [(hero_id, coords, move_dist)]
	var rand_hero_idx = randi_range(0, nearest_heroes_data.size()-1)
	_cur_target_id = nearest_heroes_data[rand_hero_idx][0]
	_cur_target_coords = nearest_heroes_data[rand_hero_idx][1]
	_cur_target_move_dist = nearest_heroes_data[rand_hero_idx][2]


func can_move():
	return _stats._cur_speed > 0


func is_skill_usable(skill):
	var is_usable = true
	if not skill.is_usable() \
	or _stats._cur_speed < skill._cost:
		is_usable = false
	return is_usable


func is_target_in_range(skill):
	return (_cur_target_id >= 0 && _cur_target_move_dist <= skill._range)
