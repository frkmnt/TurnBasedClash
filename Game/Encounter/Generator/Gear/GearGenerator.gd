extends Node

#=== About ===#
# Generates heros based on a series of parameters. The generated data is then applied to a blank Hero class to create a new custom hero.


#=== Prefabs ===#
#const _weapon_generator_template = preload("res://Character/Data/Stats.gd")
#const _arcane_blast_template = preload("res://Character/Skills/SkillList/Wizard/ArcaneBlast.gd")


#=== References ===#
var _armor_generator
var _weapon_generator


#=== Bootstrap ===#

func _ready():
	_armor_generator = $ArmorGenerator
	_weapon_generator = $WeaponGenerator


# Choose gear from the entire pool randomly.
#TODO Receive a list of biomes as difficulty, etc.
func generate_random_gear():
	pass


# Receive a Str gear_type and generate a random weapon
# Add new matches to expand generation behaviour
#TODO add tiers
func generate_rand_gear_by_type(gear_type):
	var gear
	match gear_type:
		"weapon":
			gear = _weapon_generator.generate_random_weapon()
		"armor":
			pass
	
	return gear





