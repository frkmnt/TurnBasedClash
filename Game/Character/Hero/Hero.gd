extends Node

#=== About ===#
# The base hero class. Can be abstracted into the different classes available in the game.



#=== Components ===#
var _animator

#=== Variables ===#
var _name = "Hero"

var _class = "Wizard"
var _level = 1
#var _xp_until_next = 0

var _attributes
var _stats
var _modifiers
var _skills

#var _equipment




#=== Bootstrap ===#

func _ready():
	_animator = $HeroAnimator
	_animator.play_simple_anim("idle")


func initialize(hero_data):
	_name = hero_data.name
	_class = hero_data.hero_class
	_level = hero_data.level
	_attributes = hero_data.attributes
	_stats = hero_data.stats
	_modifiers = hero_data.modifiers
	_skills = hero_data.skills
	#TODO add basic attack 



#=== Trigger Logic ===#

func on_turn_start():
	var log = ""
	_stats.on_turn_start()
	log += _modifiers.on_turn_start()
	if log != "":
		_animator.queue_data_anim("log", log)


# Calculates and applies the turn start behaviour.
func apply_turn_start():
	_animator.play_anim_queue("")


func on_move(path):
	_animator.queue_data_anim("move", path)
	_animator.play_anim_queue("_on_player_character_finished_moving")

func on_finished_moving():
	if is_turn_over():
		SignalManager.emit_signal("_on_pass_turn")


# Handles the on turn end logic.
func on_turn_end():
	#TODO
	pass


#=== Hero Specific Triggers ===#

func on_skill_select(skill):
	pass





#=== Combat ===#

# Receives the attack, then passes it to the modifiers.
# Returns true if the attack connects.
func on_receive_attack(attack, accuracy):
	#TODO handle modifiers
	var does_attack_hit = _stats.try_dodging_attack(accuracy)
	return does_attack_hit


# Applies damage after passing it to the modifiers.
func on_apply_damage(physical_damage, magical_damage, true_damage):
	#TODO apply remaining modifiers
	return _stats.apply_resistances_then_damage(physical_damage, magical_damage, true_damage)



# Adds a modifiers to the existing modifier map.
# Returns true if the modifier was successfully added.
func on_receive_modifier(modifier):
	return _modifiers.add_modifier(modifier)




#=== Utils ===#

#TODO handle modifiers
func is_turn_over():
	var is_over = false
	if _stats._cur_speed <= 0:
		is_over = true
	return is_over




func calculate_hero_value():
	return 10000

func print_hero_data():
	print_hero_info()
	_attributes.print_attributes()
	_stats.print_attributes()

func print_hero_info():
	print( \
		"Name: " + _name \
		+ "\nClass: " + _class \
		+ "\nLevel: " + str(_level) \
		+ "\n"
	)
