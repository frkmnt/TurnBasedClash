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



#=== Turn Management ===#

func on_turn_start():
	_stats.on_turn_start()



#=== Action Management ===#

func on_move(path):
	_animator.play_data_anim("move", path)

func on_finished_moving():
	SignalManager.emit_signal("_on_character_finished_moving")



#=== Combat ===#

func on_receive_attack(attack):
	pass #TODO handle modifiers


func on_apply_damage(physical_damage, magical_damage, modifiers):
	_stats.apply_resistances_then_damage(physical_damage, magical_damage)
	#TODO apply remaining modifiers



#=== Utils ===#

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
